import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:panay_translator/l10n/l10n.dart';
import 'package:panay_translator/provider/locale_provider.dart';
import 'package:panay_translator/routegenerator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panay_translator/utilities/sharedPreferences/settings.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // desktop stuff:
  if (Platform.isWindows || Platform.isIOS || Platform.isLinux) {
    print("Runnning in Desktop");
    doWhenWindowReady(() {
      final win = appWindow;
      const initialSize = Size(480, 1000);
      // win.minSize = initialSize;
      win.size = initialSize;
      // win.maxSize = initialSize;
      win.alignment = Alignment.center;
      win.title = "Panay Translator";
      win.show();
    });
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          print(provider.locale);
          return MaterialApp(
            title: 'Panay Translator',
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            locale: provider.locale,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Color(0xFF38B6FF),
              accentColor: Colors.white,
              canvasColor: Colors.grey[200],
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.notoSansTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            initialRoute: '/translator',
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        });
  }
}
