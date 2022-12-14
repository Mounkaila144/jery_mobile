import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jery/Admin/ProductsAdd.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../FadeAnimation.dart';
import '../global.dart';
import '../theme.dart';



class AddOneProducss extends StatefulWidget {
  final int id;
  const AddOneProducss({Key? key, required this.id}) : super(key: key);

  @override
  State<AddOneProducss> createState() => AddOneProducssState(this.id);
}
// To parse this JSON data, do
//
//     final producs = producsFromJson(jsonString);


// To parse this JSON data, do
//
//     final producs = producsFromJson(jsonString);


Producs producsFromJson(String str) => Producs.fromJson(json.decode(str));

String producsToJson(Producs data) => json.encode(data.toJson());

class Producs {
  Producs({
    required this.id,
    required this.name,
    required this.categorieId,
    required this.price,
    required this.qty,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  int categorieId;
  String price;
  int qty;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory Producs.fromJson(Map<String, dynamic> json) => Producs(
    id: json["id"],
    name: json["name"],
    price: json["price"],
      categorieId: json["categorie_id"],
    qty: json["qty"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "categorie_id": categorieId,
    "price": price,
    "qty": qty,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}


class AddOneProducssState extends State<AddOneProducss> {
  Future<Producs>? categorie;
  final link=url;
  final int id;

  AddOneProducssState(this.id);


  @override
  void initState() {
    super.initState();
  }



  Future<Producs> ActionES({
    required String nom,
    required String price,
    required String qty,
    required XFile? photo,
  }) async {
    var image =File(photo!.path);

    final request = await http.MultipartRequest("POST", Uri.parse('http://$link/api/products'));
    request.fields['name'] = nom;
    request.fields['categorie_id'] ="$id";
    request.fields['price'] =" $price";
    request.fields['qty'] = qty;
    request.files.add(await http.MultipartFile.fromPath("file", image.path));
    var r=await request.send();
    var response=await http.Response.fromStream(r);
    final statut = response.statusCode;
    final body = response.body;
    print("statut ${response.statusCode}");
    print("statut ${response.headers}");
    print("body ${response.body}");
    if (statut == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>ProductsAdd(id: id )));
      return producsFromJson(body);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>AddOneProducss(id: id)));
      throw Exception("eureur");
    }
  }

  final ImagePicker _picker = ImagePicker();
  late final XFile? image;
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final priceController = TextEditingController();
  final qtyController = TextEditingController();
  bool valide = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.white,
            ],
          ),
        ),
        child: categorie==null?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Ajouter un nouveau Produits",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          valide
                              ? FadeAnimation(
                              1000,
                              Text(
                                "Donner invalide",
                                style: TextStyle(
                                    color: Colors.red.shade900,
                                    fontSize: 25),
                              ))
                              :
                          FadeAnimation(
                              1000,
                              Text(
                                "Entrer les donner",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              )),
                          SizedBox(
                            height: 60,
                          ),
                          FadeAnimation(
                              1.4,
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(
                                              2, 20, 121, 0.30196078431372547),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                  Colors.grey.shade200))),
                                      child: TextFormField(
                                        validator:
                                        FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(3,
                                              errorText:
                                              "Votre nom est inferieur ?? 3 Caractere"),
                                          FormBuilderValidators.required(
                                              errorText: "Votre nom est vide"),
                                        ]),
                                        controller: nomController,
                                        decoration: InputDecoration(
                                            hintText: "nom",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                  Colors.grey.shade200))),
                                      child: TextFormField(
                                        validator:
                                        FormBuilderValidators.compose([
                                          FormBuilderValidators.integer(
                                              errorText:
                                              "La valeur est inferieur ?? "),
                                          FormBuilderValidators.required(
                                              errorText: "Valeur non numerique"),
                                        ]),
                                        controller: priceController,
                                        decoration: InputDecoration(
                                            hintText: "Prix",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                  Colors.grey.shade200))),
                                      child: TextFormField(
                                        validator:
                                        FormBuilderValidators.compose([
                                          FormBuilderValidators.integer(
                                              errorText:
                                              "La valeur non numerique "),
                                          FormBuilderValidators.required(
                                              errorText: "Valeur vide"),
                                        ]),
                                        controller: qtyController,
                                        decoration: InputDecoration(
                                            hintText: "quantit??",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                  Colors.grey.shade200))),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          image = await _picker.pickImage(
                                              source: ImageSource.gallery);
                                        },
                                        child: Text("Choisir un image"),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                              1.6,
                              Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blue[900]),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          categorie = ActionES(
                                              photo: image,
                                              qty: qtyController.text,
                                              price: priceController.text,
                                              nom: nomController.text,
                                          );
                                        });
                                      } else {
                                        setState(() {
                                          valide = true;
                                        });
                                      }
                                    },
                                    child: Text(
                                      "Ajouter un categories",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ):buildFutureBuilder(),



      ),
    );
  }
  FutureBuilder<Producs> buildFutureBuilder() {
    return FutureBuilder<Producs>(
      future: categorie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          toast("Ajouter avec Success", Colors.green);
        }
        else if (snapshot.hasError) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>AddOneProducss(id: id)));
          toast("Eureur lors de l'ajout", Colors.red);
        }

        return themejolie(
          donner: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                LoadingJumpingLine.circle(
                  borderColor: Colors.black,
                  borderSize: 3.0,
                  size: 200.0,
                  backgroundColor: Colors.white,
                  duration: Duration(milliseconds: 500),
                ),
              ],
            ),
          ),);
      },
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
