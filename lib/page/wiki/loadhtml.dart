import 'dart:async' show Future;
import 'package:PanayTranslator/model/region.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlLoader extends StatefulWidget {
  final Region region;
  HtmlLoader(this.region, {Key? key}) : super(key: key);

  @override
  _HtmlLoaderState createState() => _HtmlLoaderState();
}

class _HtmlLoaderState extends State<HtmlLoader> {
  Future<String>? htmlData;

  Future<String> loadAsset() async {
    Map htmlselection = {
      1: "assets/res/iloilo.html",
      2: "assets/res/aklan.html",
      3: "assets/res/capiz.html",
      4: "assets/res/antique.html",
    };

    return await rootBundle.loadString(htmlselection[widget.region.regionID]);
  }

  @override
  void initState() {
    htmlData = getHtmlData();
    super.initState();
  }

  Future<String> getHtmlData() async {
    return await loadAsset();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: htmlData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Html(
              data: snapshot.data as String,
              style: {
                "*": Style(
                  backgroundColor: Theme.of(context).canvasColor,
                )
              },
            );
          } else {
            return SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            );
          }
        });
  }
}
