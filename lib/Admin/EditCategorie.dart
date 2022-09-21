import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jery/Admin/CategorieAdd.dart';
import 'package:jery/Admin/ProductsAdd.dart';
import 'package:jery/main.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FadeAnimation.dart';
import '../global.dart';
import '../theme.dart';


// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'AddOneProducts.dart';

class EditCategorie extends StatefulWidget {
  final int id;
  final String name;
  final String active;


  const EditCategorie({Key? key, required this.id, required this.name, required this.active}) : super(key: key);

  @override
  State<EditCategorie> createState() => EditCategorieState(this.id,this.name,this.active);
}


class EditCategorieState extends State<EditCategorie> {
  Future<Producs>? product;
  final link=url;
  final int id;
  final String name;
  final String active;

  EditCategorieState(this.id,this.name,this.active);
  var nameController;
  var activeController;
  var qtyController;
  @override
  void initState() {
    super.initState();
    setState(() {
      nameController = TextEditingController(text:name);
      activeController = TextEditingController(text: active);
    });
  }


  Future<Producs> ActionES({
    required String nom,
    required String active,
  }) async {
     Map<String, String> buildHeaders({String? accessToken}) {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      if (accessToken != null) {
        headers['Authorization'] = 'Bearer $accessToken';
      }
      return headers;
    }

    final response = await http.put(Uri.parse('http://$link/api/categories/$id'),
        headers:buildHeaders(),
        body: jsonEncode(
    {
    'name': nom,
    'is_active': active
    },),);
    final statut = response.statusCode;
    final body = response.body;
    print("statut ${response.statusCode}");
    print("body ${response.body}");
    if (statut == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>CategoriesAdd()));
      return producsFromJson(body);
    } else {
      throw Exception("eureur");
    }
  }
  final _formKey = GlobalKey<FormState>();
  bool valide = false;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
          child: product==null?
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
                          "Modifier la categorie",
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
                                  "Valeur invalide",
                                  style: TextStyle(
                                      color: Colors.red.shade900,
                                      fontSize: 25),
                                ))
                                :
                            FadeAnimation(
                                1000,
                                Text(
                                  "Entrer les nouveaux valeur",
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
                                                "Le nom est invalide"),
                                            FormBuilderValidators.required(
                                                errorText: "Le nom est vide"),
                                          ]),
                                          controller: nameController,
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
                                            FormBuilderValidators.minLength(1,
                                                errorText:
                                                "Active est invalide"),
                                            FormBuilderValidators.required(
                                                errorText: "Active est vide"),
                                          ]),
                                          controller: activeController,
                                          decoration: InputDecoration(
                                              hintText: "Active",
                                              hintStyle:
                                              TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
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
                                          print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                                          setState(() {
                                            product = ActionES(
                                                nom: nameController.text,
                                                active: activeController.text
                                            );
                                          });
                                        } else {
                                          setState(() {
                                            valide = true;
                                          });
                                        }
                                      },
                                      child: Text(
                                        "Modifier",
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
      future: product,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
         
        } else if (snapshot.hasError) {
          return   themejolie(
            donner: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  FadeAnimation(1, Text("${snapshot.error}", style: TextStyle(color: Colors.white, fontSize: 30),))
                  ,
                  SizedBox(
                    height: 70,
                  ),
                  FadeAnimation(
                    1.6,
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.red[900]),
                      child: Center(
                        child:TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: Text("Retour", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
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

}
