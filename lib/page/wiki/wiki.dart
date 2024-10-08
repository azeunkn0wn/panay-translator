import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panay_translator/drawer.dart';
import 'package:panay_translator/model/region.dart';
import 'package:panay_translator/page/wiki/wikibuttons.dart';
import 'package:panay_translator/utilities/database.dart';

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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/mainmenu', (_) => false);
        return false;
      },
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.wiki),
            toolbarTextStyle: Theme.of(context).textTheme.bodyMedium,
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
          ),
          drawer: MainDrawer(
            currentPage: '/wiki',
          ),
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
                  return Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
