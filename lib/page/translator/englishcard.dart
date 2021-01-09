import 'package:flutter/material.dart';

class EnglishCard extends StatelessWidget {
  final bool active;
  EnglishCard({this.active = false});

  @override
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
        minLines: !active
            ? 3
            : 1, // in-line if-else statement. if not active minLines = 3, else minLines = 1
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'English',
          hintStyle: TextStyle(
            color: !active ? Theme.of(context).accentColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
