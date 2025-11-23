import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';
import '../../../bookmark/data/repositories/bookmark_repository.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers({required int page, required int pageSize});
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final BookmarkRepository _bookmarkRepository;

  UserRepositoryImpl(this._remoteDataSource, this._bookmarkRepository);

  @override
  Future<List<UserModel>> getUsers({
    required int page,
    required int pageSize,
  }) async {
    final remoteUsers = await _remoteDataSource.getUsers(
      page: page,
      pageSize: pageSize,
    );
    final List<UserModel> bookmarkedUsers = await _bookmarkRepository
        .getBookmarkedUsers();

    return remoteUsers.map((UserModel user) {
      final isBookmarked = bookmarkedUsers.any(
        (UserModel bUser) => bUser.userId == user.userId,
      );
      return user.copyWith(isBookmarked: isBookmarked);
    }).toList();
  }
}
