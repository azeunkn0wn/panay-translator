import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panay_translator/drawer.dart';
import 'package:panay_translator/model/phrase.dart';
import 'package:panay_translator/utilities/database.dart';
import 'package:panay_translator/utilities/tts.dart';

class PhrasebookPage extends StatefulWidget {
  PhrasebookPage({Key? key, String title = 'Favorites'}) : super(key: key);

  @override
  PhrasebookPageState createState() => PhrasebookPageState();
}

class PhrasebookPageState extends State<PhrasebookPage> {
  late Future<List<Phrase>> _getEnglishPhrases;

  SQLiteDatabaseProvider db = SQLiteDatabaseProvider();
  @override
  void initState() {
    super.initState();
    _getEnglishPhrases = db.getPhrases(0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/mainmenu', (_) => false);
        return false;
      },
      child: Scaffold(
        drawer: MainDrawer(
          currentPage: '/phrasebook',
        ),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.phrasebook),
        ),
        body: FutureBuilder(
          future: _getEnglishPhrases,
          builder: (context, AsyncSnapshot<List<Phrase>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.length > 0) {
                return Container(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      return Card(
                        child: ListTile(
                          onLongPress: () {
                            PhraseTTS()
                                .speak(snapshot.data![index].phrase, true);
                          },
                          // trailing: IconButton(
                          //   onPressed: () {
                          //     PhraseTTS().speak(snapshot.data![index].phrase, true);
                          //   },
                          //   icon: Icon(Icons.volume_up_rounded),
                          // ),
                          title: Text(snapshot.data![index].phrase),
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
                      Text(AppLocalizations.of(context)!.noPhrasebook,
                          style: TextStyle(color: Colors.grey, fontSize: 30)),
                      Text(
                        AppLocalizations.of(context)!.noPhrasebookMessage,
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
        ),
      ),
    );
  }
}
