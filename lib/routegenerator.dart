import 'package:PanayTranslator/page/translator/translator.dart';
import 'package:PanayTranslator/page/wiki/wiki.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    print(settings.name);

    switch (settings.name) {
      case '/translator':
        return MaterialPageRoute(builder: (_) => Translator());
      case '/wiki':
        return MaterialPageRoute(builder: (_) => Wiki());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text('Error')),
          body: Center(child: Text('Page not found')));
    });
  }
}
