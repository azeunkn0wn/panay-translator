import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panay_translator/l10n/l10n.dart';
import 'package:panay_translator/provider/locale_provider.dart';
import 'package:panay_translator/routegenerator.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
            title: "Panay Translator",
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            locale: provider.locale,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Color(0xFF5FB2F6),
              canvasColor: Colors.grey[200],
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.notoSansTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            initialRoute: '/mainmenu',
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        });
  }
}
