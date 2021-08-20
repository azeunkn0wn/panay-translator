import 'package:PanayTranslator/routegenerator.dart';
import 'package:flutter/material.dart';

void main() {
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
          primaryColor: Color(0xFF38B6FF), //0xFF144FFF //Colors.blue[600],
          accentColor: Colors.white,
          canvasColor: Colors.grey[200],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme()),

      initialRoute: '/translator', // DO NOT CHANGE

      onGenerateRoute: RouteGenerator.generateRoute,
      // navigatorObservers: [
      //   HeroController(),
      // ],
    );
  }
}
