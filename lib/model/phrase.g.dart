// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phrase _$PhraseFromJson(Map<String, dynamic> json) => Phrase(
      (json['phraseID'] as num).toInt(),
      json['phrase'] as String,
      Language.fromJson(json['language'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PhraseToJson(Phrase instance) => <String, dynamic>{
      'phraseID': instance.phraseID,
      'phrase': instance.phrase,
      'language': instance.language.toJson(),
    };
