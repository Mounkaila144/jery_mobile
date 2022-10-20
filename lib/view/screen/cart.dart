import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Admin/CartScreen.dart';
import '../../global.dart';
import '../../model/productsModel.dart';
import '../../viewModel/drawer_screen_provider.dart';
import '../../viewModel/productsVm.dart';
import '../widgets/Sidebar.dart';
import '../widgets/cartIteme.dart';
import 'package:http/http.dart' as http;


// To parse this JSON data, do
//
//     final commandes = commandesFromJson(jsonString);

Commandes commandesFromJson(String str) => Commandes.fromJson(json.decode(str));

String commandesToJson(Commandes data) => json.encode(data.toJson());

class Commandes {
  Commandes({
    required this.id,
    required this.status,
    required this.contenue,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int status;
  String contenue;
  int userId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Commandes.fromJson(Map<String, dynamic> json) => Commandes(
    id: json["id"],
    status: json["status"],
    contenue: json["contenue"],
    userId: json["user_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "contenue": contenue,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final link=url;

  static Map<String, String> buildHeaders({String? accessToken}) {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }
  static final HttpWithMiddleware https =
  HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);
  Future<Commandes> ActionES({
    required String contenue,
  }) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var id = _prefs.get("id");
    final response = await http.post(Uri.parse('http://$link/api/commandes'),
      headers:buildHeaders(),
      body: jsonEncode(
        {
          "status":true,
          "contenue":contenue,
          "user_id":id
        },
      ),
    );
    var statut = response.statusCode;
    var body = response.body;
    print(statut);
    print(body);
    if (statut == 200) {
      return commandesFromJson(response.body);
    } else {
      throw Exception("eureur");
    }
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Consumer<ProductsVM>(
      builder: (context, value, child) => Scaffold(
        body:
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blueAccent.shade100,
                  Colors.white,
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      ActionES(contenue:jsonEncode(value.panier));
                      value.delAll();
                      toast("Commandes envoyer",Colors.green);
                      Provider.of<DrawerScreenProvider>(context, listen: false)
                          .changeCurrentScreen(CustomScreensEnum.commandesEnvoyer);
                    },
                    child: Container(
                      color: Colors.yellow.shade900,
                      alignment: Alignment.center,
                      height: 50.0,
                      child: const Text(
                        'Commander',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                         value.lst.length,

                        (index) =>
                           Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.horizontal,
                            background:
                            Container(
                              color: Colors.red,
                            ),
                            onDismissed: (direction) {
                              value.del(index);
                            },
                            child:
                            CartItem(
                              screenSize: screenSize,
                              image: value.lst[index].image,
                              itemName: value.lst[index].name,
                              qty: value.lst[index].qty,
                              price: value.lst[index].price,
                            ),
                          ),
                      ),

                  ),
            Column(
              children: [
                ReusableWidget(
                          title: 'Prix Total',
                          value: r'$' + ("${value.total} ")),
              ],
            ),
                ],
              ),
            ),
          ),
      )
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