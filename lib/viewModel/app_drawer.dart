import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer_screen_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              margin:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                color: Colors.blue[200],
              ),
              child: const Center(
                child: Text(
                  'Drawer App',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          DrawerTile(
              title: 'Home',
              icon: Icons.menu,
              onTap: () {
                Provider.of<DrawerScreenProvider>(context, listen: false)
                    .changeCurrentScreen(CustomScreensEnum.panier);
                Navigator.pop(context);
              }),
          DrawerTile(
              title: 'My Account',
              icon: Icons.login,
              onTap: () {
                Provider.of<DrawerScreenProvider>(context, listen: false)
                    .changeCurrentScreen(CustomScreensEnum.listCategorie);
                Navigator.pop(context);
              }),
          DrawerTile(
              title: 'My Purchases', icon: Icons.history_rounded, onTap: () {}),
          DrawerTile(title: 'Sign Out', icon: Icons.logout, onTap: () {})
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0,
      leading: Icon(icon, color: Colors.black),
      title: Text(title,
          style: const TextStyle(fontSize: 12, color: Colors.black)),
    );
  }
}