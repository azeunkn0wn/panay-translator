import 'package:PanayTranslator/page/translator/languagelist.dart';
import 'package:flutter/material.dart';

class LocalCard extends StatelessWidget {
  final bool active;
  final Language language;
  LocalCard({this.language, this.active = false});

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: !active
            ? Theme.of(context).primaryColor
            : Theme.of(context).accentColor,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      child: TextField(
        enabled: active,
        maxLines: 6,
        minLines: !active ? 3 : 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: language.name,
          hintStyle: TextStyle(
            color: !active ? Theme.of(context).accentColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
