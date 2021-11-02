import 'package:flutter/material.dart';
import 'package:panay_translator/model/phrase.dart';
import 'package:panay_translator/utilities/sharedPreferences/favorites.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:panay_translator/utilities/tts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key, String title = 'Favorites'}) : super(key: key);

  @override
  FavoritesPageState createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Phrase>> _getfavoriteList;

  @override
  void initState() {
    super.initState();
    _getfavoriteList = Favorites().getPhrases();
  }

  removeFromFavorites(Phrase phrase) async {
    await Favorites().removePhrase(phrase);
    setState(() {
      _getfavoriteList = Favorites().getPhrases();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getfavoriteList,
      builder: (context, AsyncSnapshot<List<Phrase>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.length > 0) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  return Slidable(
                    secondaryActions: [
                      Card(
                        child: IconSlideAction(
                          caption: 'remove',
                          color: Colors.red[300],
                          icon: Icons.delete_outline_rounded,
                          onTap: () {
                            removeFromFavorites(snapshot.data![index]);
                          },
                        ),
                      ),
                    ],
                    actionPane: SlidableScrollActionPane(),
                    actionExtentRatio: 0.25,
                    child: Card(
                      child: ListTile(
                        onLongPress: () {
                          PhraseTTS()
                              .speak(snapshot.data![index].phrase, false);
                        },
                        trailing: IconButton(
                            onPressed: () {
                              PhraseTTS()
                                  .speak(snapshot.data![index].phrase, false);
                            },
                            icon: Icon(Icons.volume_up_rounded)),
                        title: Text(snapshot.data![index].phrase),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline_rounded,
                      size: 100, color: Colors.grey),
                  Text(AppLocalizations.of(context)!.error,
                      style: TextStyle(color: Colors.grey, fontSize: 30))
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.star_border_rounded,
                      size: 150, color: Colors.grey),
                  Text(AppLocalizations.of(context)!.noFavorites,
                      style: TextStyle(color: Colors.grey, fontSize: 30)),
                  Text(
                    AppLocalizations.of(context)!.noFavoritesMessage,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          );
        }
      },
    );
    // );
  }
}
