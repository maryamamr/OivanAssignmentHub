import '../../../../../../core/abstract/base_cubit.dart';
import '../../../../user_list/data/models/user_model.dart';
import '../../../data/repositories/bookmark_repository.dart';
import 'bookmark_state.dart';

class BookmarkCubit extends BaseCubit<BookmarkState> {
  final BookmarkRepository _bookmarkRepository;

  BookmarkCubit(this._bookmarkRepository) : super(const BookmarkState());

  Future<void> getBookmarkedUsers() async {
    emit(state.copyWith(status: BookmarkStatus.loading));
    try {
      final users = await _bookmarkRepository.getBookmarkedUsers();
      emit(state.copyWith(status: BookmarkStatus.success, bookmarkedUsers: users));
    } catch (e) {
      emit(state.copyWith(status: BookmarkStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> bookmarkUser(UserModel user) async {
    try {
      await _bookmarkRepository.bookmarkUser(user);
      await getBookmarkedUsers();
    } catch (e) {
      emit(state.copyWith(status: BookmarkStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> unbookmarkUser(int userId) async {
    try {
      await _bookmarkRepository.unbookmarkUser(userId);
      await getBookmarkedUsers();
    } catch (e) {
      emit(state.copyWith(status: BookmarkStatus.error, errorMessage: e.toString()));
    }
  }
}
