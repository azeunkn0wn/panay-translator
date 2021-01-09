import 'package:PanayTranslator/drawer.dart';
import 'package:PanayTranslator/page/translator/englishcard.dart';
import 'package:PanayTranslator/page/translator/languagelist.dart';
import 'package:PanayTranslator/page/translator/localcard.dart';
import 'package:flutter/material.dart';

class Translator extends StatefulWidget {
  const Translator({Key key, String title}) : super(key: key);

  @override
  _TranslatorState createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  bool swapped;

// Drop Down Menu for Language
  Language _selectedLanguage;
  List<DropdownMenuItem<Language>> _dropdownMenuItems;
  List<Language> _languageList = [
    Language(1, "Ilonggo"),
    Language(2, "Akeanon"),
    Language(3, "Hiligaynon"),
    Language(4, "Kinaray-a")
  ];

  List<DropdownMenuItem<Language>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<Language>> items = List();
    for (Language listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  // Drop Down Menu for Language *END

  void initState() {
    super.initState();
    swapped = false;
    _dropdownMenuItems = buildDropDownMenuItems(_languageList);
    _selectedLanguage = _dropdownMenuItems[0].value;
  }

  Widget englishBar() {
    return Text(
      'English',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 15,
      ),
    );
  }

  Widget localLanguagesBar() {
    return Container(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Language>(
            elevation: 9,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15,
            ),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).primaryColor,
            ),
            value: _selectedLanguage,
            items: _dropdownMenuItems,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value;
              });
            }),
      ),
    );
  }

  Widget languageOrientation(String position) {
    List<Widget> orientation = [];
    List<Widget> cards = [];
    if (swapped) {
      orientation = [englishBar(), localLanguagesBar()];
      cards = [
        EnglishCard(active: true),
        LocalCard(language: _selectedLanguage)
      ];
    } else {
      orientation = [localLanguagesBar(), englishBar()];
      cards = [
        LocalCard(language: _selectedLanguage, active: true),
        EnglishCard()
      ];
    }

    if (position == 'left') {
      return orientation[0];
    }
    if (position == 'right') {
      return orientation[1];
    }
    if (position == 'card1') {
      return cards[0];
    }
    if (position == 'card2') {
      return cards[1];
    }
    return Text('error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panay Translator'),
      ),
      drawer: MainDrawer(),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 45,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: languageOrientation('left'),
                  ),
                ),
                RaisedButton(
                  elevation: 0,
                  color: Theme.of(context)
                      .canvasColor, //transparent background color
                  shape: CircleBorder(),
                  onPressed: () {
                    setState(() {
                      swapped = !swapped;
                    });
                  },
                  child: Icon(Icons.swap_horiz,
                      size: 45, color: Theme.of(context).primaryColor),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: languageOrientation('right'),
                  ),
                ),
              ],
            ),
          ),
          languageOrientation('card1'),
          languageOrientation('card2'),
        ],
      ),
    );
  }
}
