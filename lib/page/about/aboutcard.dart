import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panay_translator/utilities/photohero.dart';

class AboutCard extends StatelessWidget {
  AboutCard({Key? key, required this.data}) : super(key: key);

  final Map data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(children: [
                        SizedBox(
                            width: 24, child: FaIcon(FontAwesomeIcons.idCard)),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        Expanded(child: Text(data["name"]))
                      ]),
                      Row(children: [
                        SizedBox(
                            width: 24, child: FaIcon(FontAwesomeIcons.phone)),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        Expanded(child: Text(data["contact"])),
                      ]),
                      Row(children: [
                        SizedBox(width: 24, child: FaIcon(FontAwesomeIcons.at)),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        Expanded(child: Text(data["email"])),
                      ]),
                      Row(children: [
                        SizedBox(
                            width: 24,
                            child: FaIcon(FontAwesomeIcons.facebookSquare)),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        Expanded(child: Text(data["facebook"])),
                      ]),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: PhotoHero(
                  photo: data["photo"],
                  width: MediaQuery.of(context).size.height / 3,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
