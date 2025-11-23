import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String bookMarkBox = 'bookmarks';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(bookMarkBox);
  }

  Box<String> get bookmarksBox => Hive.box<String>(bookMarkBox);

  Future<void> saveBookmark(String key, String value) async {
    await bookmarksBox.put(key, value);
  }

  String? getBookmark(String key) {
    return bookmarksBox.get(key);
  }

  Future<void> deleteBookmark(String key) async {
    await bookmarksBox.delete(key);
  }

  List<String> getAllBookmarks() {
    return bookmarksBox.values.toList();
  }

  Future<void> clearAllBookmarks() async {
    await bookmarksBox.clear();
  }
}
