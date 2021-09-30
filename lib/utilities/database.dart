import 'dart:io';

import 'package:flutter/services.dart';
import 'package:panay_translator/model/language.dart';
import 'package:panay_translator/model/phrase.dart';
import 'package:panay_translator/model/region.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class SQLiteDatabaseProvider {
  static final SQLiteDatabaseProvider db = SQLiteDatabaseProvider();
  Database? _database;
  bool fresh = false;
  bool useAltDataProvider = false;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    if (fresh) {
      await populateDatabase();
      fresh = false;
    }
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "translator.db");
    try {
      return await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: _onCreate,
      );
    } on MissingPluginException {
      useAltDataProvider = true;
      print("sqflite not supported by the platform");
    } catch (error) {
      useAltDataProvider = true;
      print(error.toString());
    }
  }

  void _onCreate(Database db, int version) async {
    fresh = true;
    await db.execute("""
          CREATE TABLE Phrase(
          phraseID INTEGER PRIMARY KEY,           
          phrase TEXT,
          languageID INTEGER,
          FOREIGN KEY(languageID) REFERENCES Language(languageID))          
        """);

    await db.execute("""
          CREATE TABLE Language(
          languageID INTEGER PRIMARY KEY, 
          language TEXT,
          regionID INTEGER,
          FOREIGN KEY(regionID) REFERENCES Region(regionID))
        """);
    await db.execute("""
          CREATE TABLE TranslationPivot(
          translation_id INTEGER PRIMARY KEY, 
          phraseID_english INTEGER,
          phraseID_local INTEGER,
          FOREIGN KEY(phraseID_english) REFERENCES Language(phraseID),
          FOREIGN KEY(phraseID_local) REFERENCES Language(phraseID)
          )
        """);
    await db.execute("""
          CREATE TABLE Region(
          regionID INTEGER PRIMARY KEY, 
          regionName TEXT,
          logo TEXT          
          )
        """);
  }

  // Insert region
  static Map<String, Region> regionList = {
    "iloilo": Region(1, "Iloilo", "assets/images/logo/iloilo.png"),
    "aklan": Region(2, "Aklan", "assets/images/logo/aklan.png"),
    "capiz": Region(3, "Capiz", "assets/images/logo/capiz.png"),
    "antique": Region(4, "Antique", "assets/images/logo/antique.png")
  };

  static Map<String, Language> languageList = {
    'english': Language(0, "English"),
    'iloilo': Language(1, "Ilonggo", region: regionList['iloilo']),
    'aklan': Language(2, "Akeanon", region: regionList['aklan']),
    'capiz': Language(3, "Hiligaynon", region: regionList['capiz']),
    'antique': Language(4, "Kinaray-a", region: regionList['antique']),
  };
  static Map<String, List<String>> translationData = {
    // "english": ["ilonggo", "akeanon", "hiligaynon", "kinaray-a"],
    "good morning": [
      "ma-ayong aga",
      "mayad nga agahon",
      "ma-ayong aga",
      "mayad nga aga"
    ],
    "good afternoon": [
      "ma-ayong hapon",
      "mayad nga hapon",
      "ma-ayong hapon",
      "mayad nga hapon"
    ],
    "good evening": [
      "ma-ayong gab-i",
      "mayad nga gabi-i",
      "ma-ayong gab-i",
      "mayad nga gab-i"
    ],
    "do you speak english": [
      "kabalo ka maghambal inglis",
      "makahambae ka it english",
      "kabalo ka maghambal inglis",
      "kama-an kaw maghambal kang inglis"
    ],
    "how much": ["tagpila", "tig-pila ea", "tagpila", "tag pira"],
    "i don't know": [
      "waay ako kabalo",
      "uwa ko kasayud",
      "wala ako kabalo",
      "wara takən kamaan"
    ],
    "what is your name": [
      "ano ngalan mo",
      "ano imong pangaean",
      "ano ngalan nimo",
      "ano ngaran mo"
    ],
    "thank you": ["salamat", "saeamat", "salamat", "salamat"],
    "where are you going": [
      "diin ka makadtu",
      "siin ka gaadto",
      "sa diin ka makadto",
      "diin kaw makadto"
    ],
    "hurry": ["dasiga", "dali-a", "dasiga", "dasig"],
    "where did you come from": [
      "di-in ka halin",
      "siin ikaw nag halin",
      "di-in ka halin",
      "diin ikaw alin"
    ],
    "i don't understand": [
      "wala ko kabalo",
      "wa takon kasayod",
      "wala ako kabalo",
      "wa ako kamaan"
    ],
    "Goodbye": ["Malakat na kami", "Paaeam", "Asta sa liwat", "Babay"],
    "Delicious": ["Manamit", "Manami", "Kanami gid", "Tam-is"],
    "I'm sorry": [
      "Pasensyaha lang ako",
      "Pasensyahe gid",
      "Pasensyaha lang ako",
      "Patawad"
    ],
    "Beautiful": ["Gwapa", "Kagwapa", "Gwapa", "Tisay"],
    "Ugly": ["Law-ay", "Kaeaw-ay", "Law-ay", "Raw-ay"],
    "Handsome": ["Gwapo", "Kagwapo", "Gwapo", "Tisoy"],
    "I need your help": [
      "Kinanglan ko sang bulig mo",
      "Kelangan ko ing bulig",
      "Kinihanglan ko sang bulig mo",
      "Kinanglan ko imong bulig"
    ],
    "Yes": ["Hu-o", "Hu-o", "Hu-o", "O-ud"],
    "No": ["Indi", "Bukon", "Hindi", "Indi"],
    "Please": ["Palihog", "Pangabay", "Palihog", "Palihog"],
    "Where is the bathroom": [
      "Diin ang banyo",
      "Siin kampi ro paealigsan",
      "Diin ang banyo",
      "Sa diin ang banyo"
    ],
    "I love you": [
      "Palangga ta ka",
      "Palangga tah",
      "Palangga ko ikaw",
      "Ginagugma ta ikaw"
    ],
    "I'm hungry": ["Nagutom ako", "Nagutom tang", "Nagutom ako", "Nagutom ako"],
  };

  Future<void> populateDatabase() async {
    final Database? db = await database;
    if (useAltDataProvider) {
      return;
    }

    // truncate tables
    print(await db!.delete('Language'));
    print('deleted Language');
    print(await db.delete('Region'));
    print('deleted region');
    print(await db.delete('Phrase'));
    print('deleted Phrase');
    print(await db.delete('TranslationPivot'));
    print('deleted TranslationPivot');

    try {
      await db.transaction((txn) async {
        Batch batch = txn.batch();
        regionList.forEach((key, region) {
          Map map = region.toMap();
          batch.insert('Region', {
            'regionID': map['regionID'],
            'regionName': map['regionName'],
            'logo': map['logo']
          });
        });
        await batch.commit();
      });
    } catch (error) {
      throw Exception('Transaction error: ' + error.toString());
    }

    try {
      await db.transaction((txn) async {
        Batch batch = txn.batch();
        languageList.forEach((key, language) {
          Map map = language.toMap();
          batch.insert('Language', {
            'languageID': map['languageID'],
            'language': map['language'],
            'regionID': map['region'] == null ? null : map['region'].regionID
          });
        });
        await batch.commit();
      });
    } catch (error) {
      throw Exception('Transaction error: ' + error.toString());
    }

    // translation data.
    // format: {'english': ["ilonggo", "akeanon", "hiligaynon", "kinaray-a"],}
    // all in lower case

    try {
      await db.transaction((txn) async {
        translationData.forEach((english, local) async {
          int englishPhraseID;
          List<int> localPhraseID = [];
          //english
          englishPhraseID = await txn.insert(
              'Phrase',
              {
                'phrase': english.toLowerCase(),
                'languageID': 0,
              },
              conflictAlgorithm: ConflictAlgorithm.replace);
          // ilonggo
          localPhraseID.add(await txn.insert(
              'Phrase',
              {
                'phrase': local[0].toLowerCase(),
                'languageID': 1,
              },
              conflictAlgorithm: ConflictAlgorithm.replace));
          // akeanon
          localPhraseID.add(await txn.insert(
              'Phrase',
              {
                'phrase': local[1].toLowerCase(),
                'languageID': 2,
              },
              conflictAlgorithm: ConflictAlgorithm.replace));
          // hiligaynon
          localPhraseID.add(await txn.insert(
              'Phrase',
              {
                'phrase': local[2].toLowerCase(),
                'languageID': 3,
              },
              conflictAlgorithm: ConflictAlgorithm.replace));
          //kinaray
          localPhraseID.add(await txn.insert(
              'Phrase',
              {
                'phrase': local[3].toLowerCase(),
                'languageID': 4,
              },
              conflictAlgorithm: ConflictAlgorithm.replace));
          // connect these phrase in TranslationPivot table
          Batch batch = txn.batch();
          for (int id in localPhraseID) {
            batch.insert('TranslationPivot', {
              'phraseID_english': englishPhraseID,
              'phraseID_local': id,
            });
          }

          await batch.commit();
          print('finished populating');
        });
      });
    } catch (error) {
      throw Exception('Transaction error: ' + error.toString());
    }
  }

  Future<Map> getRegionLanguage() async {
    final Database? db = await database;
    Map<int?, Region> regions = {};
    Map<int?, Language> languages = {};

    if (useAltDataProvider) {
      regionList.forEach((key, value) {
        regions[regionList[key]!.regionID] = regionList[key] as Region;
      });

      languageList.forEach((key, value) {
        languages[languageList[key]!.languageID] =
            languageList[key] as Language;
      });
      return {'regions': regions, 'languages': languages};
    }
    final List<Map<String, dynamic>> regionsQuery = await db!.query('Region');

    for (Map<String, dynamic> i in regionsQuery) {
      if (i.containsKey('regionID')) {
        regions[i['regionID']] = Region.fromMap(i);
      }
    }

    final List<Map<String, dynamic>> languagesQuery =
        await db.query('Language');

    for (Map<String, dynamic> i in languagesQuery) {
      Map map = Map.of(i);
      if (map.containsKey('languageID')) {
        if (map['regionID'] != null) {
          map['region'] = regions[map['regionID']];
        }
        languages[map['languageID']] = Language.fromMap(i);
      }
    }

    return {'regions': regions, 'languages': languages};
  }

  Future<List<Phrase>> toLocal(String phrase) async {
    final Database? db = await database;
    if (useAltDataProvider) {
      return [];
    }
    List<Phrase> result = [];
    final List<Map<String, dynamic>> phrases = await db!.rawQuery('''
    SELECT tp.translation_id, loc.phraseID, loc.phrase, loc.languageID, lang.language
    FROM TranslationPivot tp
    JOIN Phrase eng ON phraseID_english = eng.phraseID
    JOIN Phrase loc ON phraseID_local = loc.phraseID
    JOIN Language lang ON loc.languageID = lang.languageID
    WHERE (eng.phrase = ?);
  ''', [phrase]);
    for (Map<String, dynamic> phrase in phrases) {
      Map<String, dynamic> _phrase = Map<String, dynamic>.from(phrase);
      Map<String, dynamic> lang = {
        'language': {
          'language': _phrase.remove('language'),
          'languageID': _phrase.remove('languageID')
        }
      };

      _phrase.addAll(lang);

      result.add(Phrase.fromMap(_phrase));
    }

    return result;
  }

  Future<List<Phrase>> toEnglish(String phrase, int? languageID) async {
    final Database? db = await database;
    if (useAltDataProvider) {
      return [];
    }
    List<Phrase> result = [];
    final List<Map<String, dynamic>> phrases = await db!.rawQuery('''
    SELECT tp.translation_id, eng.phraseID, eng.phrase, eng.languageID, lang.language
  FROM TranslationPivot tp
    JOIN Phrase eng ON phraseID_english = eng.phraseID
    JOIN Phrase loc ON phraseID_local = loc.phraseID
    JOIN Language lang ON eng.languageID = lang.languageID   
  WHERE (loc.phrase = ? AND loc.languageID = ?);
  ''', [phrase, languageID]);

    for (Map<String, dynamic> phrase in phrases) {
      Map<String, dynamic> _phrase = Map<String, dynamic>.from(phrase);
      Map<String, dynamic> lang = {
        'language': {
          'language': _phrase.remove('language'),
          'languageID': _phrase.remove('languageID')
        }
      };

      _phrase.addAll(lang);

      result.add(Phrase.fromMap(_phrase));
    }
    return result;
  }

  Future<List<Phrase>> getPhrases(int? languageID) async {
    final Database? db = await database;
    if (useAltDataProvider) {
      return [];
    }
    List<Phrase> result = [];

    final List<Map<String, dynamic>> phrases = await db!.rawQuery('''
    SELECT ph.phraseID, ph.phrase, lang.languageID, lang.language
    FROM Phrase ph
    JOIN Language lang ON ph.languageID = lang.languageID      
    WHERE (ph.languageID = ?);
  ''', [languageID]);

    for (Map<String, dynamic> phrase in phrases) {
      Map<String, dynamic> _phrase = Map<String, dynamic>.from(phrase);
      Map<String, dynamic> lang = {
        'language': {
          'language': _phrase.remove('language'),
          'languageID': _phrase.remove('languageID')
        }
      };

      _phrase.addAll(lang);

      result.add(Phrase.fromMap(_phrase));
    }
    return result;
  }
}
