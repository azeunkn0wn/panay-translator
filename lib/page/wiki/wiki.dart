import 'dart:async';
import 'package:PanayTranslator/model/region.dart';
import 'package:PanayTranslator/page/wiki/wikibuttons.dart';
import 'package:PanayTranslator/utilities/database.dart';
import 'package:flutter/material.dart';
import 'package:PanayTranslator/drawer.dart';

class Wiki extends StatefulWidget {
  @override
  _WikiState createState() => _WikiState();
}

class _WikiState extends State<Wiki> {
  SQLiteDatabaseProvider db = SQLiteDatabaseProvider();
  Future<List?>? getRegion;
  Region? regions;

  @override
  void initState() {
    super.initState();
    getRegion = getData();
  }

  Future<List?> getData() async {
    Map data = await db.getRegionLanguage();
    List<Region> regionList = [];
    data['regions'].forEach((key, value) {
      print(value);
      regionList.add(value);
    });
    print('finished getting regions from database');

    return regionList;
  }

  List<WikiButtons> wikiButtonsList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar:
            AppBar(title: Text('Wiki'), textTheme: Theme.of(context).textTheme),
        drawer: MainDrawer(),
        body: FutureBuilder(
            future: getRegion,
            builder: (context, AsyncSnapshot<List?> snapshot) {
              if (snapshot.hasData) {
                wikiButtonsList = [];
                snapshot.data!.forEach((element) {
                  wikiButtonsList.add(WikiButtons(element));
                });

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Wrap(
                        direction: Axis.vertical,
                        runSpacing: 20,
                        spacing: 20,
                        children: wikiButtonsList,
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                );
              }
            }),
      ),
    );
  }
}
