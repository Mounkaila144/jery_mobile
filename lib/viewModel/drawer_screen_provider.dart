import 'package:flutter/material.dart';
import 'package:jery/Menu.dart';
import 'package:jery/view/screen/cart.dart';

class DrawerScreenProvider extends ChangeNotifier {
  late Widget _currentScreen = Menu();
  Widget get currentScreen => _currentScreen;
  set currentScreen(Widget newScreen) {
    _currentScreen = newScreen;
    notifyListeners();
  }

  void changeCurrentScreen(CustomScreensEnum screen){
    switch(screen){
      case CustomScreensEnum.homeScreen:
        currentScreen = Menu();
        break;
      case CustomScreensEnum.profileScreen:
        currentScreen =  CartScreen();
        break;
      default:
        currentScreen =Menu();
        break;
    }
  }
}

enum CustomScreensEnum {
  homeScreen,
  profileScreen
}