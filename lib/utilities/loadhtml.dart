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
  Future<String>? htmlData;

  Future<String> loadAsset() async {
    if (widget.page == 'touristspots') {
      return await rootBundle.loadString(
          "assets/res/adventour/${widget.region.regionName!.toLowerCase()}.html");
    }
    return await rootBundle.loadString(
        "assets/res/wiki/${widget.region.regionName!.toLowerCase()}.html");
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
    return Container(
      color: Theme.of(context).canvasColor.withAlpha(128),
      child: FutureBuilder(
          future: htmlData,
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
