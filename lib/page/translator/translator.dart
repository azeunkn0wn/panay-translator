import 'package:PanayTranslator/drawer.dart';
import 'package:PanayTranslator/page/translator/languagelist.dart';
// import 'package:PanayTranslator/page/translator/englishcard.dart';
// import 'package:PanayTranslator/page/translator/localcard.dart';
import 'package:flutter/material.dart';

class Translator extends StatefulWidget {
  Translator({Key key, String title}) : super(key: key);
  @override
  _TranslatorState createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  bool swapped;

  Map<String, List<String>> translationData = {
    'english': ["ilonggo", "akeanon", "hiligaynon", "kinaray-a"],
    'good morning': [
      "ma-ayong aga",
      "mayad nga agahon",
      "ma-ayong aga",
      "mayad nga aga"
    ],
    'good afternoon': [
      "ma-ayong hapon",
      "mayad nga hapon",
      "ma-ayong hapon",
      "mayad nga hapon"
    ],
    'good evening': [
      "ma-ayong gab-i",
      "mayad nga gabi-i",
      "ma-ayong gab-i",
      "mayad nga gab-i"
    ],
  };
// Drop Down Menu for Language
  List<DropdownMenuItem<Language>> _dropdownMenuItems;

  // font size config:
  double languageBarSize = 16;
  double languageCardSize = 24;

  List<Language> _languageList = [
    Language(0, "Ilonggo", "assets/images/logo/iloilo.png"),
    Language(1, "Akeanon", "assets/images/logo/aklan.png"),
    Language(2, "Hiligaynon", "assets/images/logo/capiz.png"),
    Language(3, "Kinaray-a", "assets/images/logo/antique.png")
  ];

  Language _selectedLanguage;

  final englishText = TextEditingController();
  final localText = TextEditingController();

  void initState() {
    super.initState();
    swapped = false;
    _dropdownMenuItems = buildDropDownMenuItems(_languageList);
    _selectedLanguage = _dropdownMenuItems[0].value;

    englishText.addListener(_englishTextListener);
    localText.addListener(_localTextTextListener);
  }

  @override
  void dispose() {
    localText.dispose();
    englishText.dispose();
    super.dispose();
  }

  clearTextFields() {
    localText.clear();
    englishText.clear();
  }

  _englishTextListener() {
    String output = '';
    String input = englishText.text.toLowerCase().trim();

    if (swapped) {
      if (translationData.containsKey(input)) {
        output = translationData[input][_selectedLanguage.id];
      } else {
        output = '';
      }

      if (output != null) {
        setState(() {
          localText.value = TextEditingValue(text: output);
        });
      }
    }
  }

  _localTextTextListener() {
    String output = '';
    String input = localText.text.toLowerCase().trim();
    if (!swapped) {
      translationData.forEach((english, local) {
        if (local[_selectedLanguage.id] == input) {
          output = english.toString();
        } else {
          output = '';
        }
      });

      if (output != null) {
        setState(() {
          englishText.value = TextEditingValue(text: output);
        });
      }
    }
  }

  Widget englishBar() {
    return Text(
      'English',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: languageBarSize,
      ),
    );
  }

  // make a language list widget for dropdown list
  List<DropdownMenuItem<Language>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<Language>> items = List();
    for (Language listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Row(
            children: [
              Image.asset(
                listItem.logo,
                height: 60,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
              ),
              Container(
                child: Text(
                  listItem.name,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                ),
              ),
            ],
          ),
          value: listItem,
        ),
      );
    }
    return items;
  }

  Widget localLanguagesBar() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<Language>(
          isExpanded: true,
          selectedItemBuilder: (BuildContext context) {
            return _languageList.map<Widget>((language) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  language.name,
                ),
              );
            }).toList();
          },
          elevation: 9,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: languageBarSize,
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).primaryColor,
          ),
          value: _selectedLanguage,
          items: _dropdownMenuItems,
          onChanged: (value) {
            setState(() {
              print(englishText.text);
              _selectedLanguage = value;
            });
          }),
    );
  }

  Widget languageOrientation(String position) {
    List<Widget> orientation = [];
    List<Widget> cards = [];
    if (swapped) {
      orientation = [englishBar(), localLanguagesBar()];
      cards = [
        englishCard(active: true),
        localCard(language: _selectedLanguage)
      ];
    } else {
      orientation = [localLanguagesBar(), englishBar()];
      cards = [
        localCard(language: _selectedLanguage, active: true),
        englishCard()
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
      body: Column(
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
                    alignment: Alignment.center,
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
                      clearTextFields();
                    });
                  },
                  child: Icon(Icons.swap_horiz,
                      size: 45, color: Theme.of(context).primaryColor),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
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

  Widget englishCard({bool active = false}) {
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
      child: Column(
        children: [
          // Text('English'),
          TextField(
            style: TextStyle(
              fontSize: languageCardSize,
              color: !active
                  ? Theme.of(context).accentColor
                  : Theme.of(context).primaryColor,
            ),
            controller: englishText,
            enabled: active,
            maxLines: 6,
            minLines: !active
                ? 3
                : 1, // in-line if-else statement. if not active minLines = 3, else minLines = 1
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'English',
              hintStyle: TextStyle(
                fontSize: 16,
                color: !active ? Theme.of(context).accentColor : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget localCard({bool active = false, Language language}) {
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
      child: Column(
        children: [
          // Text(language.name),
          TextField(
            style: TextStyle(
              fontSize: languageCardSize,
              color: !active
                  ? Theme.of(context).accentColor
                  : Theme.of(context).primaryColor,
            ),
            enabled: active,
            controller: localText,
            maxLines: 6,
            minLines: !active ? 3 : 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: language.name,
              hintStyle: TextStyle(
                fontSize: 16,
                color: !active ? Theme.of(context).accentColor : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
