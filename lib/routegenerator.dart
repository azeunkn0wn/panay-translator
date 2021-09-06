import 'package:panay_translator/model/region.dart';
import 'package:panay_translator/page/about/aboutpage.dart';
import 'package:panay_translator/page/adventour/adventour_page_view.dart';
import 'package:panay_translator/page/translator/translator.dart';
import 'package:panay_translator/page/wiki/wiki.dart';
import 'package:panay_translator/page/wiki/wikipage.dart';
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
      case '/adventour':
        return MaterialPageRoute(builder: (_) => AdventourPageView());
      case '/about':
        return MaterialPageRoute(builder: (_) => AboutPage());

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
