// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      json['regionID'] as int?,
      json['regionName'] as String?,
      json['logo'] as String?,
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'regionID': instance.regionID,
      'regionName': instance.regionName,
      'logo': instance.logo,
    };
