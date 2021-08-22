import 'package:PanayTranslator/model/region.dart';
import 'package:PanayTranslator/page/wiki/wikibuttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WikiAntique extends StatelessWidget {
  final Region region;
  WikiAntique(this.region);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        timeDilation = 1;
        return true;
      },
      child: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Press on the plus to add items above and below'),
          // ),
          body: SafeArea(
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            SliverAppBar(
              stretch: true,
              // collapsedHeight: 100,
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
            // SliverGrid(
            //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //     maxCrossAxisExtent: 200.0,
            //     mainAxisSpacing: 10.0,
            //     crossAxisSpacing: 10.0,
            //     childAspectRatio: 4.0,
            //   ),
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       return Container(
            //         alignment: Alignment.center,
            //         color: Colors.teal[100 * (index % 9)],
            //         child: Text('Grid Item $index'),
            //       );
            //     },
            //     childCount: 20,
            //   ),
            // ),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('List Item $index'),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
