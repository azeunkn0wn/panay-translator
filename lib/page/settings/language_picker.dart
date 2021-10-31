import 'package:flutter/material.dart';
import 'package:panay_translator/l10n/l10n.dart';
import 'package:panay_translator/provider/locale_provider.dart';
import 'package:panay_translator/utilities/sharedPreferences/settings.dart';
import 'package:provider/provider.dart';

class LanguagePickerPage extends StatelessWidget {
  const LanguagePickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageList = L10n.all;

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: languageList.length,
        itemBuilder: (context, index) {
          if (languageList.isEmpty) {
            return Container();
          }
          final language = languageList[index];
          final languageName = L10n.getLanguageName(language.languageCode);
          return ListTile(
            enableFeedback: true,
            title: Text(languageName['localName']!),
            subtitle: Text(languageName['englishName']!),
            onTap: () {
              final provider =
                  Provider.of<LocaleProvider>(context, listen: false);

              provider.setLocale(language);
              Settings().setSettings('languageCode', language.languageCode);
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}
