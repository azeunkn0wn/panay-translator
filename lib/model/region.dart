import 'package:json_annotation/json_annotation.dart';
part 'region.g.dart';

@JsonSerializable()
class Region {
  final int? regionID;
  final String? regionName;
  final String? logo;

  Region(
    this.regionID,
    this.regionName,
    this.logo,
  );
  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);

  factory Region.fromMap(map) {
    return Region(
      map['regionID'] as int?,
      map['regionName'] as String?,
      map['logo'] as String?,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'regionID': regionID,
      'regionName': regionName,
      'logo': logo,
    };
  }

  @override
  String toString() {
    return "$regionName";
  }
}
