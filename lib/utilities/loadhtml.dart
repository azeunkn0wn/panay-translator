import 'dart:async' show Future;
import 'package:panay_translator/model/region.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlLoader extends StatefulWidget {
  final Region region;
  final String page;
  HtmlLoader(this.region, {this.page = 'wiki'});

  @override
  _HtmlLoaderState createState() => _HtmlLoaderState();
}

class _HtmlLoaderState extends State<HtmlLoader> {
  Future<String> loadAsset(String languageCode) async {
    String page = widget.page;
    String filename = "${widget.region.regionName!.toLowerCase()}.html";

    if (languageCode != 'en') {
      filename =
          "${widget.region.regionName!.toLowerCase()}_$languageCode.html";
    }

    return await rootBundle.loadString("assets/res/$page/$filename");
  }

  @override
  void initState() {
    super.initState();
  }

  Future<String> getHtmlData(String languageCode) async {
    return await loadAsset(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;

    return Container(
      color: Theme.of(context).canvasColor.withAlpha(128),
      child: FutureBuilder(
          future: getHtmlData(languageCode),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Html(
                data: snapshot.data as String,
                style: {
                  "*": Style(
                      // backgroundColor: Theme.of(context).canvasColor,
                      backgroundColor: Colors.transparent)
                },
              );
            } else {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
              );
            }
          }),
    );
  }
}
