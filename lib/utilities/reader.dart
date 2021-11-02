import 'package:flutter/material.dart';

// TODO:
// class Reader extends StatelessWidget {
//   Reader(
//       {Key? key,
//       required this.header,
//       required this.paragraph,
//       this.headerTextSize,
//       this.paragraphTextSize,
//       this.image})
//       : super(key: key);
//   double? headerTextSize = 20;
//   double? paragraphTextSize = 10;
//   String header;
//   List<String> paragraph = [];
//   String? image;

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       image != null ? Image(image: AssetImage(image!)) : Container(),
//       RichText(
//         text: TextSpan(
//           text: 'Hello ',
//           style: DefaultTextStyle.of(context).style,
//           children: const <TextSpan>[
//             TextSpan(
//                 text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
//             TextSpan(text: ' world!'),
//           ],
//         ),
//       ),
//     ]);
//   }
// }
