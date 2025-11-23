import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oivan_assignment/core/localization/app_localizations.dart';
import 'package:oivan_assignment/core/constants/app_colors.dart';
import 'package:oivan_assignment/core/constants/ui_const.dart';
import 'package:oivan_assignment/shared_widgets/stateless/appbar.dart';
import 'package:oivan_assignment/shared_widgets/stateless/custom_text.dart';
import '../../../../../di/injector.dart';
import '../blocs/user_list_cubit/user_list_cubit.dart';
import '../blocs/user_list_cubit/user_list_state.dart';
import '../../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../bookmark/presentation/blocs/bookmark_cubit/bookmark_cubit.dart';
import '../../../bookmark/presentation/pages/bookmark_page.dart';
import '../widgets/user_item_widget.dart';
import '../../../user_details/presentation/pages/user_detail_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final _scrollController = ScrollController();
  late UserListCubit _userListCubit;
  late BookmarkCubit _bookmarkCubit;

  @override
  void initState() {
    super.initState();
    _userListCubit = Injector().userListCubit..getUsers();
    _bookmarkCubit = Injector().bookmarkCubit;
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _userListCubit.close();
    _bookmarkCubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _userListCubit.getUsers();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _userListCubit),
        BlocProvider.value(value: _bookmarkCubit),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppLocalizations.appTitle,
          actions: [
            IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.8),
                child: Icon(Icons.bookmarks, color: AppColors.primaryColor),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BookmarkPage()),
                ).then((_) => _userListCubit.getUsers(isRefresh: true));
              },
            ),
          ],
        ),
        body: CustomAppPage(
          child: BlocBuilder<UserListCubit, UserListState>(
            builder: (context, state) {
              if (state.status == UserListStatus.loading &&
                  state.users.isEmpty) {
                return const CustomLoading(
                  loadingStyle: LoadingStyle.shimmerList,
                );
              } else if (state.status == UserListStatus.error &&
                  state.users.isEmpty) {
                return Center(
                    child: CustomText(
                        state.errorMessage ?? AppLocalizations.error));
              } else if (state.users.isEmpty) {
                return Center(child: CustomText(AppLocalizations.noUsersFound));
              }

              return RefreshIndicator.adaptive(
                onRefresh: () async => _userListCubit.getUsers(isRefresh: true),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: UIConst.verticalPadding,
                  ),
                  controller: _scrollController,
                  itemCount: state.hasReachedMax
                      ? state.users.length
                      : state.users.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.users.length) {
                      return const CustomLoading(
                        loadingStyle: LoadingStyle.pagination,
                      );
                    }
                    final user = state.users[index];
                    return UserItemWidget(
                      user: user,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UserDetailPage(user: user),
                          ),
                        );
                      },
                      onBookmarkToggle: () {
                        if (user.isBookmarked) {
                          _bookmarkCubit.unbookmarkUser(user.userId);
                        } else {
                          _bookmarkCubit.bookmarkUser(user);
                        }
                        _userListCubit.changeuserBookmarkStatus(
                            user.userId, user.isBookmarked);
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
