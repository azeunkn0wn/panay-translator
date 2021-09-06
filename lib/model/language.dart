import 'package:panay_translator/model/region.dart';
import 'package:equatable/equatable.dart';

class Language extends Equatable {
  final int? languageID;
  final String? language;
  final Region? region;
  final String? logo;

  Language(this.languageID, this.language, {this.region})
      : logo = region == null ? "" : region.logo;

  factory Language.fromMap(map) {
    return Language(
      map['language_id'] as int?,
      map['language'] as String?,
      region: map['region'] as Region?,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'language_id': languageID,
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
