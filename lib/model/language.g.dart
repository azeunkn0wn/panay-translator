// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      (json['languageID'] as num).toInt(),
      json['language'] as String,
      region: json['region'] == null
          ? null
          : Region.fromJson(json['region'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'languageID': instance.languageID,
      'language': instance.language,
      'region': instance.region?.toJson(),
    };
