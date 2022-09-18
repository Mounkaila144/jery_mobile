import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jery/viewModel/LogibVm.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Admin/AddUsers.dart';
import '../../Admin/CategorieAdd.dart';
import '../../CategorieList.dart';
import '../../Login.dart';
import '../../Menu.dart';
import '../../viewModel/drawer_screen_provider.dart';


class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {

  Deconnexion() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('token');
    await _prefs.remove('role');
    await _prefs.remove('id');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginVm>(
      builder: (context, value, child) =>
          Drawer(
        backgroundColor: Colors.blue.shade100,

        child:
       value.admin?
                ListView(
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
                        color: Colors.blue.shade900,size: 35,
                      ),
                      title: const Text('Menu'),
                      onTap: () {
                        Provider.of<DrawerScreenProvider>(context, listen: false)
                            .changeCurrentScreen(CustomScreensEnum.profileScreen);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: Colors.blue.shade900,size: 35,
                      ),
                      title: const Text('Modifier mon compte'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>Menu()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.local_convenience_store,
                        color: Colors.blue.shade900,size: 35,
                      ),
                      title: const Text('Ajouter des Categories'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>CategoriesAdd()));
                      },
                    ),

                    ListTile(
                      leading: Icon(
                        Icons.store_outlined,
                        color: Colors.blue.shade900,size: 35,
                      ),
                      title: const Text('Geré les utilisateurs'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>AddUser()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.storefront_outlined,
                        color: Colors.blue.shade900,size: 35,
                      ),
                      title: const Text('Listes des Utilisateurs'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>Menu()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.blue.shade900,size: 35,
                      ),
                      title: const Text('Deconnection'),
                      onTap: () {
                        Provider.of<LoginVm>(context,listen: false).connect=false;
                        Provider.of<LoginVm>(context,listen: false).admin=false;
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>Menu()));
                      },
                    ),

                  ],
                ):
       (value.connect?
                ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    const UserAccountsDrawerHeader(
                      // <-- SEE HERE
                      decoration: BoxDecoration(color: const Color(0xff370488)),
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
                        color: Colors.blue.shade900,size: 35,
                      ),
                      title: const Text('Menu'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>Menu()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: Colors.blue.shade900,size: 35,
                      ),
                      title: const Text('Modifier mon compte'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>Menu()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.local_convenience_store,
                        color: Colors.blue.shade900,size: 35,
                      ),
                      title: const Text('Listes des Categories'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>CategoriesList()));
                      },
                    ),

                    ListTile(
                      leading: Icon(
                        Icons.store_outlined,
                        color: Colors.blue.shade900,size: 35,
                      ),
                      title: const Text('Commandes envoyer'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>Menu()));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.blue.shade900,size: 35,
                      ),
                      title: const Text('Deconnection'),
                      onTap: () {
                        Deconnexion();
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>Menu()));
                      },
                    ),

                  ],
                ):

       ListView(
         // Important: Remove any padding from the ListView.
         padding: EdgeInsets.zero,
         children: [
           const UserAccountsDrawerHeader(
             // <-- SEE HERE
             decoration: BoxDecoration(color: const Color(0xff370488)),
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
               color: Colors.blue.shade900,size: 35,
             ),
             title: const Text('Menu'),
             onTap: () {
               Navigator.push(context, MaterialPageRoute(builder:
                   (context)=>Menu()));
             },
           ),

           ListTile(
             leading: Icon(
               Icons.login,
               color: Colors.blue.shade900,size: 35,
             ),
             title: const Text('Connexion'),
             onTap: () {
               Navigator.push(context, MaterialPageRoute(builder:
                   (context)=>Login()));
             },
           ),
           ListTile(
             leading: Icon(
               Icons.storefront_outlined,
               color: Colors.blue.shade900,size: 35,
             ),
             title: const Text('Listes des Categories'),
             onTap: () {
               Navigator.push(context, MaterialPageRoute(builder:
                   (context)=>CategoriesList()));
             },
           ),

         ],
       )),




      ),
    );
            }

}