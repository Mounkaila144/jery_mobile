import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jery/Admin/AddUsers.dart';
import 'package:jery/Admin/CategorieAdd.dart';
import 'package:jery/CategorieList.dart';
import 'package:jery/service.dart';
import 'package:jery/theme.dart';
import 'package:jery/view/screen/Iconcart.dart';
import 'package:jery/view/screen/cart.dart';
import 'package:jery/view/widgets/Sidebar.dart';
import 'package:jery/viewModel/LogibVm.dart';
import 'package:jery/viewModel/drawer_screen_provider.dart';
import 'package:jery/viewModel/productsVm.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Crud.dart';
import 'FadeAnimation.dart';
import 'Login.dart';
import 'home.dart';
import 'view/widgets/cartCounter.dart';

class Menu extends StatefulWidget {

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Menu',
              ),
              backgroundColor: Colors.blue.shade900,
              actions:[
                InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
          },
            child: Padding(
              padding:
              const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Icon(Icons.shopping_cart_rounded,
                          color: Colors.blue, size: 25)),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Consumer<ProductsVM>(
                      builder: (context, value, child) => CartCounter(
                        count: value.lst.length.toString(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
              ],
            ),
            drawer: Sidebar(),
            body: context.watch<DrawerScreenProvider>().currentScreen,
          );
  }
}


