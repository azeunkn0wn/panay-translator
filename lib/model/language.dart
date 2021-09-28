import 'package:json_annotation/json_annotation.dart';
import 'package:panay_translator/model/region.dart';
import 'package:equatable/equatable.dart';
part 'language.g.dart';

@JsonSerializable(explicitToJson: true)
class Language extends Equatable {
  final int languageID;
  final String language;
  final Region? region;
  final String? logo;

  Language(this.languageID, this.language, {this.region})
      : logo = region == null ? "" : region.logo;
  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  factory Language.fromMap(map) {
    return Language(
      map['languageID'] as int,
      map['language'] as String,
      region: map['region'] as Region?,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'languageID': languageID,
      'language': language,
      'region': region,
      'logo': logo
    };
  }

  @override
  List<Object?> get props => [languageID];

  @override
  String toString() {
    return "$language($languageID)";
  }
}
