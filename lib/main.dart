import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jery/Menu.dart';
import 'package:jery/view/screen/productScreen.dart';
import 'package:jery/viewModel/LogibVm.dart';
import 'package:jery/viewModel/drawer_screen_provider.dart';
import 'package:jery/viewModel/productsVm.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  HttpOverrides.global = MyHttpOverrides();

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsVM(total: 0),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginVm(admin: true, connect: false),
        ),
        ChangeNotifierProvider(
          create: (context) => DrawerScreenProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'State Management Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Colors.blueGrey[100],
          primaryColor: Colors.blue[200],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Menu(),
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
