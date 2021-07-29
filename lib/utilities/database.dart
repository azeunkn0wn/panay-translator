import 'dart:io';

import 'package:PanayTranslator/model/language.dart';
import 'package:PanayTranslator/model/phrase.dart';
import 'package:PanayTranslator/model/region.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class SQLiteDatabaseProvider {
  static final SQLiteDatabaseProvider db = SQLiteDatabaseProvider();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "translator.db");

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""
          CREATE TABLE Phrase(
          phrase_id INTEGER PRIMARY KEY,           
          phrase TEXT,
          language_id INTEGER,
          FOREIGN KEY(language_id) REFERENCES Language(language_id))          
        """);

    await db.execute("""
          CREATE TABLE Language(
          language_id INTEGER PRIMARY KEY, 
          language TEXT,
          region_id INTEGER,
          FOREIGN KEY(region_id) REFERENCES Region(region_id))
        """);
    await db.execute("""
          CREATE TABLE TranslationPivot(
          translation_id INTEGER PRIMARY KEY, 
          phrase_id_english INTEGER,
          phrase_id_local INTEGER,
          FOREIGN KEY(phrase_id_english) REFERENCES Language(phrase_id),
          FOREIGN KEY(phrase_id_local) REFERENCES Language(phrase_id)
          )
        """);
    await db.execute("""
          CREATE TABLE Region(
          region_id INTEGER PRIMARY KEY, 
          region_name TEXT,
          logo TEXT          
          )
        """);
    // populateDatabase()
  }

  Future<void> populateDatabase() async {
    final Database db = await database;
    // truncate tables
    // truncate tables
    print(await db.delete('Language'));
    print('deleted Language');
    print(await db.delete('Region'));
    print('deleted region');
    print(await db.delete('Phrase'));
    print('deleted Phrase');
    print(await db.delete('TranslationPivot'));
    print('deleted TranslationPivot');

    // Insert region
    Map<String, Region> regionList = {
      "iloilo": Region(1, "Iloilo", "assets/images/logo/iloilo.png"),
      "aklan": Region(2, "Aklan", "assets/images/logo/aklan.png"),
      "capiz": Region(3, "Capiz", "assets/images/logo/capiz.png"),
      "antique": Region(4, "Antique", "assets/images/logo/antique.png")
    };

    Map<String, Language> languageList = {
      'english': Language(0, "English"),
      'iloilo': Language(1, "Ilonggo", region: regionList['iloilo']),
      'aklan': Language(2, "Akeanon", region: regionList['aklan']),
      'capiz': Language(3, "Hiligaynon", region: regionList['capiz']),
      'antique': Language(4, "Kinaray-a", region: regionList['antique']),
    };

    try {
      await db.transaction((txn) async {
        Batch batch = txn.batch();
        regionList.forEach((key, region) {
          Map map = region.toMap();
          batch.insert('Region', {
            'region_id': map['region_id'],
            'region_name': map['region_name'],
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
          print(map);
          batch.insert('Language', {
            'language_id': map['language_id'],
            'language': map['language'],
            'region_id': map['region'] == null ? null : map['region'].regionID
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

    try {
      await db.transaction((txn) async {
        translationData.forEach((english, local) async {
          int englishPhraseID;
          List<int> localPhraseID = [];
          //english
          englishPhraseID = await txn.insert(
              'Phrase',
              {
                'phrase': english,
                'language_id': 0,
              },
              conflictAlgorithm: ConflictAlgorithm.replace);
          // ilonggo
          localPhraseID.add(await txn.insert(
              'Phrase',
              {
                'phrase': local[0],
                'language_id': 1,
              },
              conflictAlgorithm: ConflictAlgorithm.replace));
          // akeanon
          localPhraseID.add(await txn.insert(
              'Phrase',
              {
                'phrase': local[1],
                'language_id': 2,
              },
              conflictAlgorithm: ConflictAlgorithm.replace));
          // hiligaynon
          localPhraseID.add(await txn.insert(
              'Phrase',
              {
                'phrase': local[2],
                'language_id': 3,
              },
              conflictAlgorithm: ConflictAlgorithm.replace));
          //kinaray
          localPhraseID.add(await txn.insert(
              'Phrase',
              {
                'phrase': local[3],
                'language_id': 4,
              },
              conflictAlgorithm: ConflictAlgorithm.replace));
          // connect these phrase in TranslationPivot table
          Batch batch = txn.batch();
          for (int id in localPhraseID) {
            batch.insert('TranslationPivot', {
              'phrase_id_english': englishPhraseID,
              'phrase_id_local': id,
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
    final Database db = await database;

    final List<Map<String, dynamic>> regionsQuery = await db.query('Region');

    Map<int, Region> regions = {};
    for (Map i in regionsQuery) {
      if (i != null && i.containsKey('region_id')) {
        regions[i['region_id']] = Region.fromMap(i);
      }
    }

    Map<int, Language> languages = {};
    final List<Map<String, dynamic>> languagesQuery =
        await db.query('Language');

    for (Map i in languagesQuery) {
      Map map = Map.of(i);
      if (map != null && map.containsKey('language_id')) {
        if (map['region_id'] != null) {
          map['region'] = regions[map['region_id']];
        }
        languages[map['language_id']] = Language.fromMap(i);
      }
    }
    print(languages);

    return {'regions': regions, 'languages': languages};
  }

  Future<List<Phrase>> toLocal(String phrase) async {
    final Database db = await database;
    List<Phrase> result = [];
    final List<Map<String, dynamic>> phrases = await db.rawQuery('''
    SELECT tp.translation_id, loc.phrase_id, loc.phrase, loc.language_id, lang.language
    FROM TranslationPivot tp
    JOIN Phrase eng ON phrase_id_english = eng.phrase_id
    JOIN Phrase loc ON phrase_id_local = loc.phrase_id
    JOIN Language lang ON loc.language_id = lang.language_id
    WHERE (eng.phrase = ?);
  ''', [phrase]);

    for (Map phrase in phrases) {
      result.add(Phrase.fromMap(phrase));
    }

    return result;
  }

  Future<List<Phrase>> toEnglish(String phrase, int languageID) async {
    final Database db = await database;
    List<Phrase> result = [];
    final List<Map<String, dynamic>> phrases = await db.rawQuery('''
    SELECT tp.translation_id, eng.phrase_id, eng.phrase, eng.language_id, lang.language
  FROM TranslationPivot tp
    JOIN Phrase eng ON phrase_id_english = eng.phrase_id
    JOIN Phrase loc ON phrase_id_local = loc.phrase_id
    JOIN Language lang ON loc.language_id = lang.language_id
  WHERE (loc.phrase = ? AND loc.language_id = ?);
  ''', [phrase, languageID]);

    for (Map phrase in phrases) {
      result.add(Phrase.fromMap(phrase));
    }
    return result;
  }
}
