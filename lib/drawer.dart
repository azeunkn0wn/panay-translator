import 'package:flutter/material.dart';

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
            CustomDrawerListTile(Icons.translate, 'Translator',
                () => {Navigator.pushNamed(context, "/translator")}),
            CustomDrawerListTile(Icons.school, 'Wiki',
                () => {Navigator.pushNamed(context, "/wiki")}),
            CustomDrawerListTile(Icons.star_border, 'About',
                () => {print(ModalRoute.of(context)!.settings)}),
            CustomDrawerListTile(Icons.exit_to_app, 'Exit',
                () => {print(ModalRoute.of(context)!.settings.name)}),
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
        onTap: onTap as void Function()?,
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
