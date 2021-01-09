import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              child: Center(child: Text('Logo Here')),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColorLight,
                    Theme.of(context).primaryColorDark,
                  ],
                ),
              ),
            ),
            CustomDrawerListTile(Icons.translate, 'Translator', () => {}),
            CustomDrawerListTile(Icons.school, 'Wiki', () => {}),
            CustomDrawerListTile(Icons.star_border, 'About', () => {}),
            CustomDrawerListTile(Icons.exit_to_app, 'Exit', () => {}),
          ],
        ),
      ),
    );
  }
}

class CustomDrawerListTile extends StatelessWidget {
  final IconData icon;
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
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 8, 0),
          height: 50,
          child: Row(
            children: [
              Icon(icon),
              Padding(padding: EdgeInsets.only(right: 10)),
              Text(
                text,
                textScaleFactor: 1.2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
