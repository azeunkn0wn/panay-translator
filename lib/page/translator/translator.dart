import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panay_translator/model/language.dart';
import 'package:panay_translator/model/phrase.dart';
import 'package:panay_translator/utilities/database.dart';
import 'package:panay_translator/utilities/sharedPreferences/favorites.dart';
import 'package:panay_translator/utilities/tts.dart';

class Translator extends StatefulWidget {
  Translator({Key? key, String title = 'Translator'}) : super(key: key);
  @override
  _TranslatorState createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  late bool swapped;

  SQLiteDatabaseProvider db = SQLiteDatabaseProvider();

// Drop Down Menu for Language
  List<DropdownMenuItem<Language>>? _dropdownMenuItems;

  // font size config:
  double languageBarSize = 16;
  double languageCardSize = 24;

  Language? _selectedLanguage;

  final englishText = TextEditingController();
  final localText = TextEditingController();
  Map? languages;
  Future<Map?>? getLanguages;

  // favorites related variables

  Phrase? phrase;
  bool isFav = false;

  void initState() {
    super.initState();
    swapped = false;
    getLanguages = getData();

    englishText.addListener(_englishTextListener);
    localText.addListener(_localTextTextListener);
  }

  Future<Map?> getData() async {
    // await db.populateDatabase();

    Map data = await db.getRegionLanguage();
    languages = data['languages'];
    print('finished getting languages from database');

    return languages;
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

  _englishTextListener() async {
    String? output = '';
    List<Phrase> result = [];
    String input = englishText.text.toLowerCase().trim();

    // ignoring punctuation
    RegExp regExp = new RegExp(r"[^\w\s\-\']{1,}$", caseSensitive: false);
    String punctuation = regExp.stringMatch(input).toString();

    if (swapped) {
      result = await db.toLocal(input.replaceAll(regExp, ''));
      if (result.isNotEmpty) {
        phrase = (result
            .where((phrase) => phrase.language == _selectedLanguage)
            .elementAt(0));
        isFav = await Favorites().isFavorite(phrase!);
        output = phrase!.phrase;

        if (punctuation.isNotEmpty && punctuation != "null") {
          output = (output + punctuation);
        }
      } else {
        output = '';
        phrase = null;
        isFav = false;
        setState(() {
          localText.value = TextEditingValue(text: output!);
        });
      }

      if (output.isNotEmpty) {
        setState(() {
          localText.value = TextEditingValue(text: output!);
        });
      }
    }
  }

  _localTextTextListener() async {
    String? output = '';
    List result = [];
    String input = localText.text.toLowerCase().trim();

    if (!swapped) {
      result = await db.toEnglish(input, _selectedLanguage!.languageID);

      if (result.isNotEmpty) {
        output = result[0].phrase;
      } else {
        output = '';
      }

      if (output != null) {
        setState(() {
          englishText.value = TextEditingValue(text: output!);
        });
      }
    }
  }

  toggleFavorite() async {
    if (phrase == null) {
      print('phrase is null');
      return;
    }

    bool result = await Favorites().addPhrase(phrase!);

    setState(() {
      isFav = result;
    });
  }

  Widget favoritesButton() {
    late IconData icon;

    if (isFav) {
      icon = Icons.star_rounded;
    } else {
      icon = Icons.star_border_rounded;
    }

    return IconButton(
        onPressed: () {
          toggleFavorite();
        },
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
          size: 34,
        )); //
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

  Widget regionLogo(String? logo) {
    // avoid errors when logo is empty or null
    if (logo != null && logo.isNotEmpty) {
      return Image.asset(
        logo,
        height: 60,
        fit: BoxFit.fitHeight,
      );
    } else {
      return Container();
    }
  }

  List<DropdownMenuItem<Language>> buildDropDownMenuItems(Map listItems) {
    List<DropdownMenuItem<Language>> items = [];
    listItems.forEach((key, value) {
      if (value.language != 'English') {
        items.add(
          DropdownMenuItem(
            child: Row(
              children: [
                regionLogo(value.logo), // logo image widget
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                ),
                Container(
                  child: Text(
                    value.language,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                  ),
                ),
              ],
            ),
            value: value,
          ),
        );
      }
    });
    return items;
  }

  Widget localLanguagesBar() {
    languages!.remove(0);
    return DropdownButtonHideUnderline(
      child: DropdownButton<Language>(
          isExpanded: true,
          selectedItemBuilder: (BuildContext context) {
            return languages!.values.map<Widget>((language) {
              return Container(
                alignment: Alignment.center,
                child: Text(language.language),
              );
            }).toList();
          },
          elevation: 9,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
        localCard(language: _selectedLanguage!)
      ];
    } else {
      orientation = [localLanguagesBar(), englishBar()];
      cards = [
        localCard(language: _selectedLanguage!, active: true),
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
    return Text(AppLocalizations.of(context)!.error);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getLanguages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _dropdownMenuItems =
                buildDropDownMenuItems(snapshot.data as Map<int?, Language>);

            if (_selectedLanguage == null) {
              _selectedLanguage = _dropdownMenuItems![0].value;
            }

            return ListView(
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
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(CircleBorder()),
                            //  color: Theme.of(context)
                            //     .canvasColor, //transparent background color
                            backgroundColor: WidgetStateProperty.all<Color>(
                                Theme.of(context).canvasColor),
                            elevation: WidgetStateProperty.all<double>(0)),
                        onPressed: () {
                          setState(() {
                            swapped = !swapped;
                            clearTextFields();
                          });
                        },
                        child: Icon(
                          Icons.swap_horiz,
                          size: 45,
                          color: Theme.of(context).primaryColor,
                        ),
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
            );
          } else {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
            );
          }
        });
    // );
  }

  Widget englishCard({bool active = false}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: !active
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.secondary,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          TextField(
            style: TextStyle(
              fontSize: languageCardSize,
              color: !active
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).primaryColor,
            ),
            controller: englishText,
            // onChanged: _onChangeHandler,
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
                color: !active
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Visibility(
              visible: englishText.text == '' ? false : true,
              child: IconButton(
                color: !active
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).primaryColor,
                icon: Icon(Icons.volume_up, size: 35),
                onPressed: () => PhraseTTS().speak(englishText.text, true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget localCard({bool active = false, required Language language}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: !active
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.secondary,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          TextField(
            style: TextStyle(
              fontSize: languageCardSize,
              color: !active
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).primaryColor,
            ),
            enabled: active,
            controller: localText,
            // onChanged: _onChangeHandler,
            maxLines: 6,
            minLines: !active ? 3 : 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: language.language,
              hintStyle: TextStyle(
                fontSize: 16,
                color: !active
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
              ),
            ),
          ),
          Visibility(
            visible: localText.text == '' ? false : true,
            child: Row(
              children: [
                Expanded(child: Container()),
                Visibility(visible: !active, child: favoritesButton()),
                IconButton(
                  color: !active
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).primaryColor,
                  icon: Icon(Icons.volume_up, size: 35),
                  onPressed: () => PhraseTTS().speak(localText.text, false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
