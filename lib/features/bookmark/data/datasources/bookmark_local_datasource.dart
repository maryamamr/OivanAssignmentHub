import 'dart:convert';
import '../../../../core/service/hive_service.dart';
import '../../../user_list/data/models/user_model.dart';

abstract class BookmarkLocalDataSource {
  Future<List<UserModel>> getBookmarkedUsers();
  Future<void> bookmarkUser(UserModel user);
  Future<void> unbookmarkUser(int userId);
}

class BookmarkLocalDataSourceImpl implements BookmarkLocalDataSource {
  final HiveService _hiveService;

  BookmarkLocalDataSourceImpl(this._hiveService);

  @override
  Future<List<UserModel>> getBookmarkedUsers() async {
    final bookmarks = _hiveService.getAllBookmarks();
    return bookmarks.map((jsonString) {
      final json = jsonDecode(jsonString);
      return UserModel.fromJson(json);
    }).toList();
  }

  @override
  Future<void> bookmarkUser(UserModel user) async {
    final key = user.userId.toString();
    final jsonString = jsonEncode(user.toJson());
    await _hiveService.saveBookmark(key, jsonString);
  }

  @override
  Future<void> unbookmarkUser(int userId) async {
    final key = userId.toString();
    await _hiveService.deleteBookmark(key);
  }
}
