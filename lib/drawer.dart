import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panay_translator/utilities/photohero.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key, required this.currentPage, this.parentKey})
      : super(key: key);
  final String currentPage;
  final GlobalKey<dynamic>? parentKey;

  static const double iconSize = 35;

  void _onTapNavigate(BuildContext context, String newPage) {
    if (currentPage == newPage) {
      Navigator.pop(context);
    } else {
      Navigator.pushNamed(context, newPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
              child: Column(
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    // height: MediaQuery.of(context).size.width - 100,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: PhotoHero(
                        photo:
                            'assets/images/Panay Island Translator (round).png',
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  CustomDrawerListTile(
                      icon: FaIcon(
                        FontAwesomeIcons.lightLanguage,
                        size: iconSize,
                      ),
                      title: AppLocalizations.of(context)!
                          .translator, //'Translator',
                      onTap: () {
                        switch (currentPage) {
                          case ('/translator'):
                            Navigator.pop(context);
                            return;
                          case ('/favorites'):
                            Navigator.pop(context);
                            parentKey!.currentState!.changePage(0);
                            return;

                          default:
                            Navigator.pushNamed(context, "/translator");
                            return;
                        }
                      }),
                  CustomDrawerListTile(
                      icon: FaIcon(
                        FontAwesomeIcons.wikipediaW,
                        size: iconSize,
                      ),
                      title: AppLocalizations.of(context)!.wiki,
                      onTap: () {
                        _onTapNavigate(context, '/wiki');
                      }),
                  CustomDrawerListTile(
                      icon: FaIcon(
                        FontAwesomeIcons.lightStar,
                        size: iconSize,
                      ),
                      title: AppLocalizations.of(context)!.favorites,
                      onTap: () {
                        switch (currentPage) {
                          case ('/favorites'):
                            Navigator.pop(context);
                            return;
                          case ('/translator'):
                            Navigator.pop(context);
                            parentKey!.currentState!.changePage(1);
                            return;

                          default:
                            Navigator.pushNamed(context, "/favorites");
                            return;
                        }
                      }),
                  CustomDrawerListTile(
                    icon: FaIcon(
                      FontAwesomeIcons.lightBookOpen,
                      size: iconSize,
                    ),
                    title: AppLocalizations.of(context)!.phrasebook,
                    onTap: () {
                      _onTapNavigate(context, '/phrasebook');
                    },
                  ),
                  CustomDrawerListTile(
                      // icon: Image.asset("assets/icon/adventour.png"),
                      icon: FaIcon(
                        FontAwesomeIcons.lightMapMarkedAlt,
                        size: iconSize,
                      ),
                      title: AppLocalizations.of(context)!.adventour,
                      onTap: () {
                        _onTapNavigate(context, '/adventour');
                      }),
                  CustomDrawerListTile(
                    icon: FaIcon(
                      FontAwesomeIcons.lightInfoCircle,
                      size: iconSize,
                    ),
                    title: AppLocalizations.of(context)!.about,
                    onTap: () {
                      _onTapNavigate(context, '/about');
                    },
                  ),
                  CustomDrawerListTile(
                    icon: FaIcon(
                      FontAwesomeIcons.lightCog,
                      size: iconSize,
                    ),
                    title: AppLocalizations.of(context)!.settings,
                    onTap: () {
                      _onTapNavigate(context, '/settings');
                    },
                  ),
                  CustomDrawerListTile(
                    icon: FaIcon(
                      FontAwesomeIcons.lightSignOut,
                      size: iconSize,
                    ),
                    title: AppLocalizations.of(context)!.exit,
                    onTap: () => {SystemNavigator.pop()},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDrawerListTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final Function? onTap;
  CustomDrawerListTile({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: onTap as void Function()?,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 8, 0),
          height: 50,
          child: Row(
            children: [
              icon,
              Padding(padding: EdgeInsets.only(right: 20)),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  textScaler: TextScaler.linear(1.5),
                  // overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
