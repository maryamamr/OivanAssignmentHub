import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/repositories/user_repository.dart';
import 'user_list_state.dart';

class UserListCubit extends BaseCubit<UserListState> {
  final UserRepository _userRepository;
  int _page = 1;
  static const int _pageSize = 15;

  UserListCubit(this._userRepository) : super(const UserListState());

  Future<void> getUsers({bool isRefresh = false}) async {
    if (state.hasReachedMax && !isRefresh) return;

    // Prevent concurrent pagination requests
    if (state.status == UserListStatus.loading && !isRefresh) return;

    try {
      if (state.status == UserListStatus.initial || isRefresh) {
        _page = 1;
        emit(state.copyWith(status: UserListStatus.loading));
        final users =
            await _userRepository.getUsers(page: _page, pageSize: _pageSize);
        emit(state.copyWith(
          status: UserListStatus.success,
          users: users,
          hasReachedMax: users.isEmpty,
        ));
      } else {
        // Increment page BEFORE making the API call
        _page++;
        final users =
            await _userRepository.getUsers(page: _page, pageSize: _pageSize);
        if (users.isEmpty) {
          emit(state.copyWith(hasReachedMax: true));
        } else {
          emit(state.copyWith(
            status: UserListStatus.success,
            users: List.of(state.users)..addAll(users),
            hasReachedMax: false,
          ));
        }
      }
    } catch (e) {
      // Decrement page on error to allow retry
      if (state.status != UserListStatus.initial && !isRefresh) {
        _page--;
      }
      emit(state.copyWith(
          status: UserListStatus.error, errorMessage: e.toString()));
    }
  }

  void changeuserBookmarkStatus(int userId, bool isBookmarked) {
    final updatedUsers = state.users.map((user) {
      if (user.userId == userId) {
        return user.copyWith(isBookmarked: !isBookmarked);
      }
      return user;
    }).toList();

    emit(state.copyWith(users: updatedUsers));
  }
}
