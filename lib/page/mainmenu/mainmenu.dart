import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panay_translator/utilities/photohero.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainMenu extends StatelessWidget {
  const MainMenu();

  static const double iconSize = 35;

  void _onTapNavigate(BuildContext context, String newPage) {
    Navigator.pushNamed(context, newPage);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              centerTitle: true,
              stretch: true,
              pinned: true,
              backgroundColor: Color(0xFFEDF2F8),
              expandedHeight: MediaQuery.of(context).size.width,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Theme.of(context).primaryColor,
                  // height: MediaQuery.of(context).size.width - 100,
                  // width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: PhotoHero(
                      photo:
                          'assets/images/Panay Island Translator (round).png',
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  MainMenuIcon(
                      icon: FaIcon(
                        FontAwesomeIcons.lightLanguage,
                        size: iconSize,
                      ),
                      title: AppLocalizations.of(context)!
                          .translator, //'Translator',
                      onTap: () {
                        _onTapNavigate(context, '/translator');
                      }),
                  MainMenuIcon(
                      icon: FaIcon(
                        FontAwesomeIcons.wikipediaW,
                        size: iconSize,
                      ),
                      title: AppLocalizations.of(context)!.wiki,
                      onTap: () {
                        _onTapNavigate(context, '/wiki');
                      }),
                  MainMenuIcon(
                      icon: FaIcon(
                        FontAwesomeIcons.lightStar,
                        size: iconSize,
                      ),
                      title: AppLocalizations.of(context)!.favorites,
                      onTap: () {
                        _onTapNavigate(context, '/favorites');
                      }),
                  MainMenuIcon(
                    icon: FaIcon(
                      FontAwesomeIcons.lightBookOpen,
                      size: iconSize,
                    ),
                    title: AppLocalizations.of(context)!.phrasebook,
                    onTap: () {
                      _onTapNavigate(context, '/phrasebook');
                    },
                  ),
                  MainMenuIcon(
                      // icon: Image.asset("assets/icon/adventour.png"),
                      icon: FaIcon(
                        FontAwesomeIcons.lightMapMarkedAlt,
                        size: iconSize,
                      ),
                      title: AppLocalizations.of(context)!.adventour,
                      onTap: () {
                        _onTapNavigate(context, '/adventour');
                      }),
                  MainMenuIcon(
                    icon: FaIcon(
                      FontAwesomeIcons.lightInfoCircle,
                      size: iconSize,
                    ),
                    title: AppLocalizations.of(context)!.about,
                    onTap: () {
                      _onTapNavigate(context, '/about');
                    },
                  ),
                  MainMenuIcon(
                    icon: FaIcon(
                      FontAwesomeIcons.lightCog,
                      size: iconSize,
                    ),
                    title: AppLocalizations.of(context)!.settings,
                    onTap: () {
                      _onTapNavigate(context, '/settings');
                    },
                  ),
                  MainMenuIcon(
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
          ],
        ),
      ),
    );
  }
}

class MainMenuIcon extends StatelessWidget {
  final Widget icon;
  final String title;
  final Function? onTap;
  MainMenuIcon({required this.icon, required this.title, this.onTap});

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
          margin: EdgeInsets.fromLTRB(50, 0, 8, 0),
          height: 50,
          child: Row(
            children: [
              icon,
              Padding(padding: EdgeInsets.only(right: 20)),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  textScaleFactor: 1.5,
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
