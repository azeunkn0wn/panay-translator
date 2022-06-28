import 'package:flutter/material.dart';
import 'package:panay_translator/utilities/photohero.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/mainmenu', (_) => false);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(AppLocalizations.of(context)!.about),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  // height: MediaQuery.of(context).size.width - 100,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: PhotoHero(
                      photo:
                          'assets/images/Panay Island Translator (round).png',
                      width: MediaQuery.of(context).size.width,
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
            ),
          ),
        ),
      ),
    );
  }
}
