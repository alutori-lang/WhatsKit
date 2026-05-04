import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  static const _key = 'app_locale';

  static const supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
    Locale('hi'),
    Locale('ur'),
    Locale('ar'),
  ];

  static const localeNames = <String, String>{
    'en': 'English',
    'it': 'Italiano',
    'hi': 'हिन्दी',
    'ur': 'اردو',
    'ar': 'العربية',
  };

  static const localeFlags = <String, String>{
    'en': '🇬🇧',
    'it': '🇮🇹',
    'hi': '🇮🇳',
    'ur': '🇵🇰',
    'ar': '🇸🇦',
  };

  Locale? _locale;
  Locale? get locale => _locale;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code != null && supportedLocales.any((l) => l.languageCode == code)) {
      _locale = Locale(code);
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
    notifyListeners();
  }

  Future<void> useSystem() async {
    _locale = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    notifyListeners();
  }
}
