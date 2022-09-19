import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';

import '../../Admin/CartScreen.dart';
import '../../global.dart';
import '../../model/productsModel.dart';
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



  Future<Commandes> ActionES({
    required String contenue,
  }) async {

    final response = await http.post(Uri.parse('http://$link/api/commandes'),
      //headers: HelperService.buildHeaders(),
      body: jsonEncode(
        {
          "status":true,
          "contenue":contenue,
          "user_id":1
        },
      ),
    );


    var statut = response.statusCode;
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
        body: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Panier',
            ),
            backgroundColor: Colors.blue.shade900,
          ),
          drawer: const Sidebar(),
          body: Container(
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
                  Column(
                    children: List.generate(
                         value.lst.length ?? 3,

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
                            child: CartItem(
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
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            ActionES(contenue:productsToJson(value.lst));
            value.delAll();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Commandes envoyer'),
                duration: Duration(seconds: 4),
              ),
            );
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
      ),
    );
  }
}