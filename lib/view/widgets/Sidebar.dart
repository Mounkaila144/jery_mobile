import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jery/Admin/CategorieAdd.dart';
import 'package:jery/Admin/ListesUsers.dart';
import 'package:jery/viewModel/LogibVm.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/getOne.dart';
import '../../service.dart';
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
  late Future <User?> user;

  Deconnexion() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('token');
    await _prefs.remove('role');
    await _prefs.remove('name');
    await _prefs.remove('role');
    await _prefs.remove('id');
    toast("Deconnecter", Colors.red);
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
                  FutureBuilder <User?>(
                    future: user=Remote().getCurentUser(),
                    builder: (context,snap){
                      if(snap.hasData) {
                        return
                          UserAccountsDrawerHeader(
                            // <-- SEE HERE
                            decoration: BoxDecoration(color: Colors.orange),
                            accountName: Text(
                              "Nom: ${snap.data!.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            accountEmail: Text(
                              "Email: ${snap.data!.email}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            currentAccountPicture: Image.asset("image/logo.png"),
                          );
                      }
                      else if(snap.hasError){
                        return
                          UserAccountsDrawerHeader(
                            // <-- SEE HERE
                            decoration: BoxDecoration(color: Colors.blue),
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
                            currentAccountPicture: Image.asset("image/logo.png"),
                          );
                      }
                      return
                        LoadingJumpingLine.circle(
                          borderColor: Colors.black,
                          borderSize: 3.0,
                          size: 150.0,
                          backgroundColor: Colors.white,
                          duration: Duration(milliseconds: 500),
                        );
                    },
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
                      Icons.account_circle,
                      color: Colors.blue.shade900,
                      size: 35,
                    ),
                    title: const Text('Modifier mon compte'),
                    onTap: () {
                      Provider.of<DrawerScreenProvider>(context, listen: false)
                          .changeCurrentScreen(CustomScreensEnum.editUser);
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
                      FutureBuilder <User?>(
                        future: user=Remote().getCurentUser(),
                        builder: (context,snap){
                          if(snap.hasData) {
                            return
                              UserAccountsDrawerHeader(
                                // <-- SEE HERE
                                decoration: BoxDecoration(color: Colors.blue),
                                accountName: Text(
                                  "Nom: ${snap.data!.name}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                accountEmail: Text(
                                  "Email: ${snap.data!.email}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                currentAccountPicture: Image.asset("image/logo.png"),
                              );
                          }
                          else if(snap.hasError){
                            return
                              UserAccountsDrawerHeader(
                                // <-- SEE HERE
                                decoration: BoxDecoration(color: Colors.green),
                                accountName: Text(
                                  "Bonjour Client",
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
                                currentAccountPicture: Image.asset("image/logo.png"),
                              );
                          }
                          return
                            LoadingJumpingLine.circle(
                              borderColor: Colors.black,
                              borderSize: 3.0,
                              size: 150.0,
                              backgroundColor: Colors.white,
                              duration: Duration(milliseconds: 500),
                            );
                        },
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
                          Icons.account_circle,
                          color: Colors.blue.shade900,
                          size: 35,
                        ),
                        title: const Text('Modifier mon compte'),
                        onTap: () {
                          Provider.of<DrawerScreenProvider>(context,
                                  listen: false)
                              .changeCurrentScreen(CustomScreensEnum.editUser);
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
                      ListTile(
                        leading: Icon(
                          Icons.store_outlined,
                          color: Colors.blue.shade900,
                          size: 35,
                        ),
                        title: const Text('Commandes envoyer'),
                        onTap: () {
                          Provider.of<DrawerScreenProvider>(context,
                                  listen: false)
                              .changeCurrentScreen(CustomScreensEnum.commandesEnvoyer);
                      Navigator.pop(context);
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
                      UserAccountsDrawerHeader(
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
                        currentAccountPicture: Image.asset("image/logo.png"),
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
  Future<bool?> toast(String message,colors) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        backgroundColor: colors,
        textColor: Colors.white,
        fontSize: 25.0);
  }
}
