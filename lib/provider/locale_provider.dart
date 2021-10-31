import 'package:flutter/material.dart';
import 'package:panay_translator/l10n/l10n.dart';
import 'package:panay_translator/utilities/sharedPreferences/settings.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale {
    if (_locale == null) {
      getLocaleSettings();
    }
    return _locale;
  }

  getLocaleSettings() async {
    Locale locale = Locale(await Settings().getSettings('languageCode'));
    _locale = locale;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
