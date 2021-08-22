import 'package:PanayTranslator/model/region.dart';
import 'package:PanayTranslator/page/translator/translator.dart';
import 'package:PanayTranslator/page/wiki/wiki-antique.dart';
import 'package:PanayTranslator/page/wiki/wiki.dart';
import 'package:PanayTranslator/page/wiki/wikipage.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/translator':
        return MaterialPageRoute(builder: (_) => Translator());
      case '/wiki':
        return MaterialPageRoute(builder: (_) => Wiki());
      case '/wikipage':
        return MaterialPageRoute(builder: (_) => WikiPage(args as Region));
      case '/test':
        return MaterialPageRoute(builder: (_) => WikiAntique(args as Region));

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
