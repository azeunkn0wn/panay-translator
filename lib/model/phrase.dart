import 'package:equatable/equatable.dart';
import 'package:panay_translator/model/language.dart';
import 'package:json_annotation/json_annotation.dart';
part 'phrase.g.dart';

@JsonSerializable(explicitToJson: true)
class Phrase extends Equatable {
  final int phraseID;
  final String phrase;
  final Language language;

  Phrase(this.phraseID, this.phrase, this.language);
  factory Phrase.fromJson(Map<String, dynamic> json) {
    return _$PhraseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PhraseToJson(this);

  factory Phrase.fromMap(map) {
    print('phrase');
    print(map);
    Language lang = Language.fromMap(map['language']);

    return Phrase(
      map['phraseID'] as int,
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
    return "Phrase($phrase, $language)";
  }

  @override
  List<Object?> get props => [phraseID];
}
