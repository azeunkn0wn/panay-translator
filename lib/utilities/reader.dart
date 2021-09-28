import 'package:flutter/material.dart';

class Reader extends StatelessWidget {
  Reader({Key? key, required this.header, paragraph, headerSize, paragraphSize})
      : super(key: key);
  final double? headerSize = 20;
  final double? paragraphTextSize = 10;
  final String header;
  final List<String> paragraph = [];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RichText(
        text: TextSpan(
          text: 'Hello ',
          style: DefaultTextStyle.of(context).style,
          children: const <TextSpan>[
            TextSpan(
                text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' world!'),
          ],
        ),
      ),
    ]);
  }
}
