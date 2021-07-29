import 'dart:async';
import 'package:flutter/material.dart';
import 'package:PanayTranslator/drawer.dart';

class Wiki extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wiki'),
        ),
        drawer: MainDrawer(),
        body: Container(
            child: ElevatedButton(
          autofocus: true,
          clipBehavior: Clip.none,
          onPressed: () {},
          child: Text("TTS"),
        )),
      ),
    );
  }
}
