import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  Widget languageSettings(BuildContext context) {
    // final locale = Localizations.localeOf(context);
    return ListTile(
      leading: Icon(Icons.translate_rounded),
      title: Text(
        //Languages
        AppLocalizations.of(context)!.languages,
      ),
      subtitle: Text(
        //Selected Language
        AppLocalizations.of(context)!.language,
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/languagePicker');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text(
              AppLocalizations.of(context)!.settings,
            )),
        body: ListView(
          children: [languageSettings(context)],
        ),
      ),
    );
  }
}
