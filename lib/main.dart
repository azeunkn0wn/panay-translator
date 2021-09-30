import 'dart:io';

import 'package:panay_translator/routegenerator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() async {
  // desktop stuff:
  if (Platform.isWindows || Platform.isIOS || Platform.isLinux) {
    WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
      title: 'Flutter Demo',
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
  }
}
