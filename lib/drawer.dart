import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panay_translator/page/translator/mainpage.dart';
import 'package:panay_translator/utilities/photohero.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key, required this.currentPage, this.parentKey})
      : super(key: key);
  final String currentPage;
  final GlobalKey<dynamic>? parentKey;

  @override
  Widget build(BuildContext context) {
    print(currentPage);
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                // height: MediaQuery.of(context).size.width - 100,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: PhotoHero(
                    photo: 'assets/images/Panay Island Translator (round).png',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              CustomDrawerListTile(
                  icon: FaIcon(
                    FontAwesomeIcons.lightLanguage,
                    size: 40,
                  ),
                  title: 'Translator',
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
                    size: 40,
                  ),
                  title: 'Wiki',
                  onTap: () => {
                        Navigator.pushNamed(context, "/wiki"),
                      }),
              CustomDrawerListTile(
                  icon: FaIcon(
                    FontAwesomeIcons.lightStar,
                    size: 40,
                  ),
                  title: 'Favorites',
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
                // icon: Image.asset("assets/icon/phrasebook.png"),
                icon: FaIcon(
                  FontAwesomeIcons.lightBookOpen,
                  size: 40,
                ),
                title: 'Phrasebook',
                onTap: () => {},
              ),
              CustomDrawerListTile(
                  // icon: Image.asset("assets/icon/adventour.png"),
                  icon: FaIcon(
                    FontAwesomeIcons.lightMapMarkedAlt,
                    size: 40,
                  ),
                  title: 'Adventour',
                  onTap: () => {
                        Navigator.pushNamed(context, "/adventour"),
                      }),
              CustomDrawerListTile(
                icon: Icon(Icons.error_outline, size: 50),
                title: 'About',
                onTap: () => {
                  Navigator.pushReplacementNamed(context, "/about"),
                },
              ),
              CustomDrawerListTile(
                icon: FaIcon(
                  FontAwesomeIcons.lightSignOut,
                  size: 40,
                ),
                title: 'Exit',
                onTap: () => {SystemNavigator.pop()},
              ),
            ],
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
              Text(
                title,
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
