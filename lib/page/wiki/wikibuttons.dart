import 'package:panay_translator/model/region.dart';
import 'package:panay_translator/utilities/photohero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WikiButtons extends StatelessWidget {
  final Region region;

  WikiButtons(this.region);

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        // border: Border.all(width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),

      margin: EdgeInsets.all(5),
      // height: 150,
      width: MediaQuery.of(context).size.width - 50,
      child: Container(
        child: InkWell(
          onTap: () {
            timeDilation = 2;
            Navigator.of(context).pushNamed('/wikipage', arguments: region);
          },
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 100,
                child: PhotoHero(
                  photo: region.logo,
                  width: 100.0,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
              Expanded(
                child: Text(
                  region.regionName!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: MediaQuery.of(context).size.width / 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
