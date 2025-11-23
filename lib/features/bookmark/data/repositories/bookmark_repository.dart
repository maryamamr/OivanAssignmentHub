import '../../../user_list/data/models/user_model.dart';
import '../datasources/bookmark_local_datasource.dart';

abstract class BookmarkRepository {
  Future<List<UserModel>> getBookmarkedUsers();
  Future<void> bookmarkUser(UserModel user);
  Future<void> unbookmarkUser(int userId);
}

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkLocalDataSource _localDataSource;

  BookmarkRepositoryImpl(this._localDataSource);

  @override
  Future<List<UserModel>> getBookmarkedUsers() async {
    final users = await _localDataSource.getBookmarkedUsers();
    return users.map((user) => user.copyWith(isBookmarked: true)).toList();
  }

  @override
  Future<void> bookmarkUser(UserModel user) async {
    await _localDataSource.bookmarkUser(user.copyWith(isBookmarked: true));
  }

  @override
  Future<void> unbookmarkUser(int userId) async {
    await _localDataSource.unbookmarkUser(userId);
  }
}
