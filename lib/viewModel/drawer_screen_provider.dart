import 'package:flutter/material.dart';
import 'package:jery/Admin/AddUsers.dart';
import 'package:jery/Admin/CategorieAdd.dart';
import 'package:jery/Admin/CommandesRecu.dart';
import 'package:jery/Admin/EditUsers.dart';
import 'package:jery/Admin/ListesUsers.dart';
import 'package:jery/CategorieList.dart';
import 'package:jery/Login.dart';
import 'package:jery/Menu.dart';
import 'package:jery/view/screen/cart.dart';

import 'package:jery/Menu.dart';

import '../MenuHome.dart';

class DrawerScreenProvider extends ChangeNotifier {
  late Widget _currentScreen = MenuHome();
  Widget get currentScreen => _currentScreen;
  set currentScreen(Widget newScreen) {
    _currentScreen = newScreen;
    notifyListeners();
  }

  void changeCurrentScreen(CustomScreensEnum screen){
    switch(screen){
      case CustomScreensEnum.menu:
        currentScreen = MenuHome();
        break;
      case CustomScreensEnum.editUser:
        currentScreen =  EditUser();
        break;
         case CustomScreensEnum.categorieAdd:
        currentScreen =  CategoriesAdd();
        break;
         case CustomScreensEnum.listUser:
        currentScreen =  ListesUsers();
        break;
         case CustomScreensEnum.addUser:
        currentScreen =  AddUser();
        break;
         case CustomScreensEnum.listCategorie:
        currentScreen =  CategoriesList();
        break;
         case CustomScreensEnum.panier:
        currentScreen =  CartScreen();
        break;
         case CustomScreensEnum.commandesRecus:
        currentScreen =  CommandeRecus();
        break;
      case CustomScreensEnum.login:
        currentScreen = Login();
        break;

      default:
        currentScreen =MenuHome();
        break;
    }
  }
}

enum CustomScreensEnum {
  homeScreen,
  profileScreen,
  menu,
  login,
  editUser,
  addUser,
  categorieAdd,
  listCategorie,
  listUser,
  panier,
  commandesRecus,
  deconnexion,


}