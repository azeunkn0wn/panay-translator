import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.width - 100,
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                margin: EdgeInsets.zero,
                child: Image.asset(
                  'assets/images/Panay Island Translator (round).png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            CustomDrawerListTile(
                Image.asset("assets/icon/translate.png"),
                'Translator',
                () => {Navigator.pushNamed(context, "/translator")}),
            CustomDrawerListTile(Image.asset("assets/icon/wiki.png"), 'Wiki',
                () => {Navigator.pushNamed(context, "/wiki")}),
            CustomDrawerListTile(
                Icon(
                  Icons.book,
                  size: 50,
                ),
                'Dictionary',
                () => {Navigator.pushNamed(context, "/wiki")}),
            CustomDrawerListTile(
                Icon(
                  Icons.star_border,
                  size: 50,
                ),
                'About',
                () => {print(ModalRoute.of(context)!.settings)}),
            CustomDrawerListTile(
                Icon(
                  Icons.exit_to_app,
                  size: 50,
                ),
                'Exit',
                () => {SystemNavigator.pop()}),
          ],
        ),
      ),
    );
  }
}

class CustomDrawerListTile extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function onTap;
  CustomDrawerListTile(this.icon, this.text, this.onTap);

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
                text,
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
