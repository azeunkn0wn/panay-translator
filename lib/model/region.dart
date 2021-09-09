class Region {
  final int? regionID;
  final String? regionName;
  final String? logo;

  Region(
    this.regionID,
    this.regionName,
    this.logo,
  );

  factory Region.fromMap(map) {
    return Region(
      map['region_id'] as int?,
      map['region_name'] as String?,
      map['logo'] as String?,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'region_id': regionID,
      'region_name': regionName,
      'logo': logo,
    };
  }

  @override
  String toString() {
    return "$regionName";
  }
}
