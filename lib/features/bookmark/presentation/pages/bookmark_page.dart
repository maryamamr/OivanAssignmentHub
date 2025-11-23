import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oivan_assignment/core/localization/app_localizations.dart';
import 'package:oivan_assignment/core/constants/ui_const.dart';
import 'package:oivan_assignment/shared_widgets/stateless/appbar.dart';
import '../../../../../di/injector.dart';
import '../../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../../../shared_widgets/stateless/custom_text.dart';
import '../../../bookmark/presentation/blocs/bookmark_cubit/bookmark_cubit.dart';
import '../../../bookmark/presentation/blocs/bookmark_cubit/bookmark_state.dart';
import '../../../user_list/presentation/widgets/user_item_widget.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late BookmarkCubit _bookmarkCubit;

  @override
  void initState() {
    super.initState();
    _bookmarkCubit = Injector().bookmarkCubit..getBookmarkedUsers();
  }

  @override
  void dispose() {
    _bookmarkCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bookmarkCubit,
      child: Scaffold(
        appBar: CustomAppBar(title: AppLocalizations.bookmarks),
        body: CustomAppPage(
          child: BlocBuilder<BookmarkCubit, BookmarkState>(
            builder: (context, state) {
              if (state.status == BookmarkStatus.loading) {
                return const CustomLoading(
                  loadingStyle: LoadingStyle.shimmerList,
                );
              } else if (state.status == BookmarkStatus.error) {
                return Center(
                    child: CustomText(
                        state.errorMessage ?? AppLocalizations.error));
              } else if (state.bookmarkedUsers.isEmpty) {
                return Center(
                    child: CustomText(AppLocalizations.noBookmarksYet));
              }

              return ListView.builder(
                itemCount: state.bookmarkedUsers.length,
                padding:
                    EdgeInsets.symmetric(vertical: UIConst.verticalPadding),
                itemBuilder: (context, index) {
                  final user = state.bookmarkedUsers[index];
                  return UserItemWidget(
                    user: user,
                    onTap: () {},
                    onBookmarkToggle: () {
                      _bookmarkCubit.unbookmarkUser(user.userId);
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
