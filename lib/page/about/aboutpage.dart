import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panay_translator/page/about/aboutcard.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);
  static const List<Map> profile = [
    {
      "name": "Glenn D. Dionio",
      "contact": "09300849818",
      "email": "glendionio17@gmail.com",
      "facebook": "Glenn Deviente Dinio",
      "photo": 'assets/images/pic/glenn.jpg',
    },
    {
      "name": "Carol Jean T. Arela",
      "contact": "09462186326",
      "email": "caroljeanarela143@gmail.com",
      "facebook": "Carol Jean Arela",
      "photo": 'assets/images/pic/carol.jpg',
    },
    {
      "name": "Anne Margarette C. Clavaton",
      "contact": "09989428540",
      "email": "anneclavaton18@gmail.com",
      "facebook": "Anne Clavaton",
      "photo": 'assets/images/pic/anne.jpg',
    },
  ];

  void getCards(profile) {}

  @override
  Widget build(BuildContext context) {
    List<AboutCard> cards = [];
    for (Map data in profile) {
      cards.add(AboutCard(data: data));
    }
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
            body: Column(
              children: cards,
            )),
      ),
    );
  }
}
