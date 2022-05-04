import 'package:panay_translator/model/region.dart';
import 'package:panay_translator/page/about/aboutpage.dart';
import 'package:panay_translator/page/adventour/adventour_page_view.dart';
import 'package:panay_translator/page/login/loginpage.dart';
import 'package:panay_translator/page/mainmenu/mainmenu.dart';

import 'package:panay_translator/page/phrasebook/phrasebook_page.dart';
import 'package:panay_translator/page/settings/language_picker.dart';
import 'package:panay_translator/page/settings/settings_page.dart';
import 'package:panay_translator/page/translator/mainpage.dart';
import 'package:panay_translator/page/wiki/wiki.dart';
import 'package:panay_translator/page/wiki/wikipage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    print(settings.name);

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainMenu());

      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/mainmenu':
        return MaterialPageRoute(builder: (_) => MainMenu());
      case ('/translator'):
        return MaterialPageRoute(
            builder: (_) => MainPage(
                  selectedPageIndex: 0,
                ));
      case '/favorites':
        return MaterialPageRoute(
            builder: (_) => MainPage(
                  selectedPageIndex: 1,
                ));
      case '/wiki':
        return MaterialPageRoute(builder: (_) => Wiki());
      case '/wikipage':
        return MaterialPageRoute(builder: (_) => WikiPage(args as Region));
      case '/phrasebook':
        return MaterialPageRoute(builder: (_) => PhrasebookPage());

      case '/adventour':
        return MaterialPageRoute(builder: (_) => AdventourPageView());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/languagePicker':
        return MaterialPageRoute(builder: (_) => LanguagePickerPage());

      case '/about':
        return MaterialPageRoute(builder: (_) => AboutPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    Future<bool> _onPop(BuildContext context) async {
      Navigator.pushNamedAndRemoveUntil(context, '/mainmenu', (_) => false);
      return false;
    }

    return MaterialPageRoute(
      builder: (context) {
        return WillPopScope(
          onWillPop: () => _onPop(context),
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(),
              automaticallyImplyLeading: true,
              centerTitle: true,
              title: Text(AppLocalizations.of(context)!.error),
            ),
            body: Center(
              child: Text(AppLocalizations.of(context)!.pageNotFound),
            ),
          ),
        );
      },
    );
  }
}
