import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App language (EN / AR). MaterialApp listens to [localeNotifier].
class LanguageStorage {
  static const String _key = 'app_language';

  static final ValueNotifier<Locale> localeNotifier = ValueNotifier<Locale>(const Locale('en'));

  /// Call once in main() before runApp.
  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    localeNotifier.value = Locale(prefs.getString(_key) ?? 'en');
  }

  static Future<void> change(String languageCode) async {
    localeNotifier.value = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, languageCode);
  }
}
