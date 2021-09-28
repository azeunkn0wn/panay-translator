import 'dart:convert';

import 'package:panay_translator/model/phrase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late List<Phrase> _phrases;

  refreshPhrases() async {
    this._phrases = [];
    String _data = await _prefs.then((SharedPreferences prefs) {
      return prefs.getString('favorites') ?? '[]';
    });
    List<dynamic> decoded = await json.decode(_data);

    List<Phrase> phrases = [];
    decoded.forEach((element) {
      Phrase phrase = Phrase.fromMap(element);
      phrases.add(phrase);
    });
    this._phrases = phrases;
  }

  Future<List<Phrase>> getPhrases() async {
    await refreshPhrases();
    return _phrases;
  }

  saveFavorites(String str) async {
    await _prefs.then((SharedPreferences prefs) {
      prefs.setString('favorites', str);
    });
    print('successfully saved: {$str}');
  }

  Future<bool> isFavorite(Phrase phrase) async {
    await refreshPhrases();
    if (_phrases.contains(phrase)) {
      return true;
    } else
      return false;
  }

  Future<bool> addPhrase(Phrase phrase) async {
    await refreshPhrases();
    try {
      if (await isFavorite(phrase)) {
        print("already in favorites");
        removePhrase(phrase);
        return false;
      } else {
        _phrases.add(phrase);
        String str = json.encode(_phrases);
        await saveFavorites(str);
        return true;
      }
    } catch (e) {
      print("error Favorites.addPhrase catched: $e");
      return false;
    }
  }

  removePhrase(Phrase phrase) async {
    if (await isFavorite(phrase)) {
      _phrases.remove(phrase);
      String str = json.encode(_phrases);
      await saveFavorites(str);
    }
  }

  clearPhrases() async {
    await _prefs.then((SharedPreferences prefs) {
      prefs.remove('favorites');
    });
    print('favorites cleared');
  }

  // testAdd() async {
  //   List<Map> xxx = [
  //     {
  //       'id': 1,
  //       'phrase': 'phrase',
  //       'language': 'language',
  //     },
  //     {
  //       'id': 2,
  //       'phrase': 'phrase2',
  //       'language': 'languag2e',
  //     },
  //   ];

  // await _prefs.then((SharedPreferences prefs) {
  //   prefs.setString('favorites', json.encode(xxx));
  // });
  // print(getPhrases());
  // }
}
