import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/repositories/reputation_repository.dart';
import 'reputation_state.dart';

class ReputationCubit extends BaseCubit<ReputationState> {
  final ReputationRepository _reputationRepository;
  int _page = 1;
  static const int _pageSize = 30;

  ReputationCubit(this._reputationRepository) : super(const ReputationState());

  Future<void> getReputation(int userId) async {
    if (state.hasReachedMax && state.status != ReputationStatus.initial) return;

    // Prevent concurrent pagination requests
    if (state.status == ReputationStatus.loading) return;

    try {
      if (state.status == ReputationStatus.initial) {
        _page = 1;
        emit(state.copyWith(status: ReputationStatus.loading));
        final history = await _reputationRepository.getReputation(
            userId: userId, page: _page, pageSize: _pageSize);
        emit(state.copyWith(
          status: ReputationStatus.success,
          reputationHistory: history,
          hasReachedMax: history.isEmpty,
        ));
      } else {
        // Increment page BEFORE making the API call
        _page++;
        final history = await _reputationRepository.getReputation(
            userId: userId, page: _page, pageSize: _pageSize);
        if (history.isEmpty) {
          emit(state.copyWith(hasReachedMax: true));
        } else {
          emit(state.copyWith(
            status: ReputationStatus.success,
            reputationHistory: List.of(state.reputationHistory)
              ..addAll(history),
            hasReachedMax: false,
          ));
        }
      }
    } catch (e) {
      // Decrement page on error to allow retry
      if (state.status != ReputationStatus.initial) {
        _page--;
      }
      emit(state.copyWith(
          status: ReputationStatus.error, errorMessage: e.toString()));
    }
  }
}
