import 'package:flutter/material.dart';
import 'package:PanayTranslator/utilities/photohero.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('About'),
          ),
          body: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: PhotoHero(
                    photo: 'assets/images/Panay Island Translator (round).png',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: RichText(
                  textScaleFactor: 1.3,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'The Panay Island Language Translator was developed by '),
                      TextSpan(
                          text: 'Glenn D. Dionio, ',
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: 'Carol Jean T. Arela, ',
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: 'Anne Margarette Clavaton ',
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              '(2021-2022) students of Filamer Christian University Roxas City. The app named Panay Island Language Translator. This application gives us the flexibility to access our system from nowhere through a powerful mobile app.'),
                    ],
                  ),
                ),
              ),
            ],
          )
          // body: CustomScrollView(
          //   slivers: [
          //     SliverAppBar(
          //       stretch: false,
          //       pinned: true,
          //       expandedHeight: 300.0,
          //       flexibleSpace: FlexibleSpaceBar(
          //         stretchModes: const <StretchMode>[
          //           StretchMode.zoomBackground,
          //           StretchMode.blurBackground,
          //         ],
          //         background: PhotoHero(
          //           photo: 'assets/images/Panay Island Translator (round).png',
          //         ),
          //       ),
          //     ),
          //     SliverList(
          //       delegate: SliverChildListDelegate.fixed(
          //         [
          //           // Padding(padding: EdgeInsets.all(10)),
          //           // Container(
          //           //   margin: EdgeInsets.all(20),
          //           //   child: Text(
          //           //     'The Panay Island Language Translator was developed by Glenn D. Dionio, Carol Jean T. Arela and Anne Margarette Clavaton (2021-2022) students of Filamer Christian University Roxas City. The app named Panay Island Language Translator. This application gives us the flexibility to access our system from nowhere through a powerful mobile app.',
          //           //     textAlign: TextAlign.center,
          //           //   ),
          //           // ),
          //           Container(
          //             margin: EdgeInsets.all(20),
          //             child: RichText(
          //               textScaleFactor: 1.3,
          //               textAlign: TextAlign.center,
          //               text: TextSpan(
          //                 // Note: Styles for TextSpans must be explicitly defined.
          //                 // Child text spans will inherit styles from parent
          //                 style: TextStyle(
          //                   fontSize: 14.0,
          //                   color: Colors.black,
          //                 ),
          //                 children: <TextSpan>[
          //                   TextSpan(
          //                       text:
          //                           'The Panay Island Language Translator was developed by '),
          //                   TextSpan(
          //                       text: 'Glenn D. Dionio, ',
          //                       style:
          //                           new TextStyle(fontWeight: FontWeight.bold)),
          //                   TextSpan(
          //                       text: 'Carol Jean T. Arela, ',
          //                       style:
          //                           new TextStyle(fontWeight: FontWeight.bold)),
          //                   TextSpan(
          //                       text: 'Anne Margarette Clavaton ',
          //                       style:
          //                           new TextStyle(fontWeight: FontWeight.bold)),
          //                   TextSpan(
          //                       text:
          //                           '(2021-2022) students of Filamer Christian University Roxas City. The app named Panay Island Language Translator. This application gives us the flexibility to access our system from nowhere through a powerful mobile app.'),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          ),
    );
  }
}
