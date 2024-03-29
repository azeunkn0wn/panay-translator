import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'), // Englinese
    const Locale('ja'), // Japanese
    Locale.fromSubtags(
        languageCode: 'zh', scriptCode: 'Hans'), // Simplified Chinese
    const Locale('ko'), // Koreanese
    const Locale('es'), // Espanese
    const Locale('fr'), // Franese
  ];

  static Map<String, String> getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return {'englishName': 'Japanese', 'localName': '日本語'};
      case 'zh':
        return {'englishName': 'Chinese', 'localName': '汉语'};
      case 'ko':
        return {'englishName': 'Korean', 'localName': '한국어'};
      case 'es':
        return {'englishName': 'Spanish', 'localName': 'Español'};
      case 'fr':
        return {'englishName': 'French', 'localName': 'Français'};
      case 'en':
      default:
        return {'englishName': 'English', 'localName': 'English'};
    }
  }
}
