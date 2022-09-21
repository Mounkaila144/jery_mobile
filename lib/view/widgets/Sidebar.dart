import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jery/Admin/CategorieAdd.dart';
import 'package:jery/Admin/ListesUsers.dart';
import 'package:jery/viewModel/LogibVm.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../viewModel/drawer_screen_provider.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  void initState() {
    Provider.of<LoginVm>(context, listen: false).connecter();
    super.initState();
  }

  Deconnexion() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('token');
    await _prefs.remove('role');
    await _prefs.remove('id');
  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<LoginVm>(
      builder: (context, value, child) => Drawer(
        backgroundColor: Colors.blue.shade100,
        child: value.admin
            ? ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const UserAccountsDrawerHeader(
                    // <-- SEE HERE
                    decoration: BoxDecoration(color: const Color(0xff370488)),
                    accountName: Text(
                      "Bonjour Admin",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    accountEmail: Text(
                      "Bienvenue",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    currentAccountPicture: FlutterLogo(),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home_outlined,
                      color: Colors.blue.shade900,
                      size: 35,
                    ),
                    title: const Text('Menu'),
                    onTap: () {
                      Provider.of<DrawerScreenProvider>(context, listen: false)
                          .changeCurrentScreen(CustomScreensEnum.menu);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.local_convenience_store,
                      color: Colors.blue.shade900,
                      size: 35,
                    ),
                    title: const Text('Ajouter des Categories'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CategoriesAdd()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.store_outlined,
                      color: Colors.blue.shade900,
                      size: 35,
                    ),
                    title: const Text('Commandes Recus'),
                    onTap: () {
                      Provider.of<DrawerScreenProvider>(context, listen: false)
                          .changeCurrentScreen(CustomScreensEnum.commandesRecus);
                      Navigator.pop(context);
                    },
                  ),
                   ListTile(
                    leading: Icon(
                      Icons.store_outlined,
                      color: Colors.blue.shade900,
                      size: 35,
                    ),
                    title: const Text('Ajouter des utilisateurs'),
                    onTap: () {
                      Provider.of<DrawerScreenProvider>(context, listen: false)
                          .changeCurrentScreen(CustomScreensEnum.addUser);
                      Navigator.pop(context);
                    },
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.storefront_outlined,
                      color: Colors.blue.shade900,
                      size: 35,
                    ),
                    title: const Text('Listes des Utilisateurs'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ListesUsers()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.blue.shade900,
                      size: 35,
                    ),
                    title: const Text('Deconnection'),
                    onTap: () {
                      Deconnexion();
                      Provider.of<DrawerScreenProvider>(context, listen: false)
                          .changeCurrentScreen(CustomScreensEnum.menu);
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            : (value.connect
                ? ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      const UserAccountsDrawerHeader(
                        // <-- SEE HERE
                        decoration:
                            BoxDecoration(color: const Color(0xff370488)),
                        accountName: Text(
                          "Bonjours ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        accountEmail: Text(
                          "Client",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        currentAccountPicture: FlutterLogo(),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.home_outlined,
                          color: Colors.blue.shade900,
                          size: 35,
                        ),
                        title: const Text('Menu'),
                        onTap: () {
                          Provider.of<DrawerScreenProvider>(context,
                                  listen: false)
                              .changeCurrentScreen(CustomScreensEnum.menu);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.local_convenience_store,
                          color: Colors.blue.shade900,
                          size: 35,
                        ),
                        title: const Text('Listes des Categories'),
                        onTap: () {
                          Provider.of<DrawerScreenProvider>(context,
                                  listen: false)
                              .changeCurrentScreen(
                                  CustomScreensEnum.listCategorie);
                          Navigator.pop(context);
                        },
                      ),
                      // ListTile(
                      //   leading: Icon(
                      //     Icons.store_outlined,
                      //     color: Colors.blue.shade900,
                      //     size: 35,
                      //   ),
                      //   title: const Text('Commandes envoyer'),
                      //   onTap: () {
                      //     Provider.of<DrawerScreenProvider>(context,
                      //             listen: false)
                      //         .changeCurrentScreen(CustomScreensEnum.menu);
                      //Navigator.pop(context);
                      //   },
                      // ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.blue.shade900,
                          size: 35,
                        ),
                        title: const Text('Deconnection'),
                        onTap: () {
                          Deconnexion();
                          Provider.of<DrawerScreenProvider>(context,
                                  listen: false)
                              .changeCurrentScreen(
                                  CustomScreensEnum.menu);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                : ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      const UserAccountsDrawerHeader(
                        // <-- SEE HERE
                        decoration:
                            BoxDecoration(color: const Color(0xff370488)),
                        accountName: Text(
                          "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        accountEmail: Text(
                          "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        currentAccountPicture: FlutterLogo(),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.home_outlined,
                          color: Colors.blue.shade900,
                          size: 35,
                        ),
                        title: const Text('Menu'),
                        onTap: () {
                          Provider.of<DrawerScreenProvider>(context,
                                  listen: false)
                              .changeCurrentScreen(
                                  CustomScreensEnum.menu);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.login,
                          color: Colors.blue.shade900,
                          size: 35,
                        ),
                        title: const Text('Connexion'),
                        onTap: () {
                          Provider.of<DrawerScreenProvider>(context,
                                  listen: false)
                              .changeCurrentScreen(
                                  CustomScreensEnum.login);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.storefront_outlined,
                          color: Colors.blue.shade900,
                          size: 35,
                        ),
                        title: const Text('Listes des Categories'),
                        onTap: () {
                          Provider.of<DrawerScreenProvider>(context,
                                  listen: false)
                              .changeCurrentScreen(
                                  CustomScreensEnum.listCategorie);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )),
      ),
    );
  }
}
