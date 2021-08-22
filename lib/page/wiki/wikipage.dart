import 'package:PanayTranslator/model/region.dart';
import 'package:PanayTranslator/page/wiki/loadhtml.dart';
import 'package:PanayTranslator/page/wiki/wikibuttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WikiPage extends StatelessWidget {
  final Region region;
  WikiPage(this.region);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        timeDilation = 1;
        return true;
      },
      child: Scaffold(
          body: SafeArea(
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            SliverAppBar(
              // title: Text(region.regionName!.toUpperCase()),
              centerTitle: true,
              stretch: true,
              pinned: true,
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  // StretchMode.blurBackground,
                ],
                background: PhotoHero(
                  photo: region.logo,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate.fixed([
              HtmlLoader(region),
              // Padding(
              //   padding: EdgeInsets.all(20),
              // ),
            ])),
          ],
        ),
      )),
    );
  }
}
