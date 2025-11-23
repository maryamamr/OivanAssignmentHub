import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oivan_assignment/core/localization/app_localizations.dart';
import 'package:oivan_assignment/core/constants/style.dart';
import 'package:oivan_assignment/core/constants/ui_const.dart';
import 'package:oivan_assignment/features/user_details/data/models/reputation_model.dart';
import 'package:oivan_assignment/features/user_details/presentation/widgets/profile_header.dart';
import '../../../../../di/injector.dart';
import '../../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../../../shared_widgets/stateless/custom_text.dart';
import '../../../user_list/data/models/user_model.dart';
import '../blocs/reputation_cubit/reputation_cubit.dart';
import '../blocs/reputation_cubit/reputation_state.dart';

class UserDetailPage extends StatefulWidget {
  final UserModel user;

  const UserDetailPage({super.key, required this.user});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final _scrollController = ScrollController();
  late ReputationCubit _reputationCubit;

  @override
  void initState() {
    super.initState();
    _reputationCubit = Injector().reputationCubit
      ..getReputation(widget.user.userId);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _reputationCubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _reputationCubit.getReputation(widget.user.userId);
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _reputationCubit,
      child: Scaffold(
        body: CustomAppPage(
          child: Column(
            children: [
              ProfileHeader(widget.user),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: UIConst.verticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(widget.user.displayName,
                        style: Theme.of(context).textTheme.titleLarge),
                    CustomText(widget.user.location),
                    CustomText(
                        '${AppLocalizations.reputation}: ${widget.user.reputation}'),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(AppLocalizations.reputationHistory,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: BlocBuilder<ReputationCubit, ReputationState>(
                  builder: (context, state) {
                    final reputationHistory = state.reputationHistory;
                    if (state.status == ReputationStatus.loading &&
                        reputationHistory.isEmpty) {
                      return const CustomLoading(
                          loadingStyle: LoadingStyle.shimmerList);
                    } else if (state.status == ReputationStatus.error &&
                        reputationHistory.isEmpty) {
                      return Center(
                          child: CustomText(
                              state.errorMessage ?? AppLocalizations.error));
                    } else if (reputationHistory.isEmpty) {
                      return Center(
                          child:
                              CustomText(AppLocalizations.noReputationHistory));
                    }
                    return RefreshIndicator.adaptive(
                      onRefresh: () async =>
                          _reputationCubit.getReputation(widget.user.userId),
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(
                            horizontal: UIConst.horizontalPadding),
                        itemCount: state.hasReachedMax
                            ? reputationHistory.length
                            : reputationHistory.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= reputationHistory.length) {
                            return const CustomLoading(
                                loadingStyle: LoadingStyle.pagination);
                          }
                          final history = reputationHistory[index];
                          return _buildReputationCard(history);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReputationCard(ReputationModel history) => Card(
        color: Colors.white,
        shape: AppStyle.cardStyle,
        child: ListTile(
          title: CustomText(
            history.reputationHistoryType,
            fontWeight: FontWeight.bold,
          ),
          subtitle: CustomText(DateFormat.yMMMd().format(
              DateTime.fromMillisecondsSinceEpoch(
                  history.creationDate * 1000))),
          trailing: CustomText(
            history.reputationChange.toString(),
            style: TextStyle(
                color:
                    history.reputationChange >= 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
      );
}
