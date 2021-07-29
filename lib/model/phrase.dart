import 'package:PanayTranslator/model/language.dart';

class Phrase {
  int phraseID;
  String phrase;
  Language language;

  Phrase(this.phraseID, this.phrase, this.language);

  factory Phrase.fromMap(map) {
    Language lang = Language.fromMap(map);
    return Phrase(
      map['phrase_id'] as int,
      map['phrase'] as String,
      lang,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': phraseID,
      'phrase': phrase,
      'language': language,
    };
  }

  @override
  String toString() {
    return "$language: $phrase";
  }
}
