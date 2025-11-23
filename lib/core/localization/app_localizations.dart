import 'dart:convert';
import 'package:flutter/services.dart';

class AppLocalizations {
  static Map<String, String> _localizedStrings = {};

  static Future<void> load(String languageCode) async {
    String jsonString =
        await rootBundle.loadString('assets/locales/$languageCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  static String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  static String get appTitle => translate('app_title');
  static String get bookmarks => translate('bookmarks');
  static String get error => translate('error');
  static String get noUsersFound => translate('no_users_found');
  static String get noBookmarksYet => translate('no_bookmarks_yet');
  static String get reputation => translate('reputation');
  static String get reputationHistory => translate('reputation_history');
  static String get noReputationHistory => translate('no_reputation_history');
}
