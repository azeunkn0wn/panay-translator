import 'package:flutter/material.dart';

import 'package:panay_translator/model/region.dart';
import 'package:panay_translator/utilities/loadhtml.dart';

class TouristSpots extends StatelessWidget {
  final Region region;

  TouristSpots({required this.region});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(region.regionName!.toUpperCase()),
        ),
        body: HtmlLoader(region, page: 'touristspots'),
      ),
    );
  }
}
