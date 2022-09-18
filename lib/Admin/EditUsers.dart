import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.emailVerifiedAt,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String role;
  String email;
  dynamic emailVerifiedAt;
  String password;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    role: json["role"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    password: json["password"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "password": password,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => EditUserState();
}


class EditUserState extends State<EditUser> {
  Future<User>? categorie;
  final link=url;


  @override
  void initState() {
    super.initState();
  }



  Future<User> ActionES({
    required String nom,
    required String email
  }) async {
    var formData ={
      "name":nom,
      "email":email
    };
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var id =_prefs.get("id");

    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    dio.options.headers["Content-Type"]="application/json";
    dio.options.headers["Accept"]="application/json";
    final response = await dio.put('http://$link/api/users/$id', data: formData);
    var statut = response.statusCode;
    if (statut == 200) {
      return userFromJson(response.data);
    } else {
      throw Exception("eureur");
    }
  }

  final ImagePicker _picker = ImagePicker();
  late final XFile? image;
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                        "Modifier votre compte",
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
                                              "Votre nom est invalide"),
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
                                          FormBuilderValidators.email(),
                                          FormBuilderValidators.required(
                                              errorText: "Valeur vide"),
                                        ]),
                                        controller: emailController,
                                        decoration: InputDecoration(
                                            hintText: "email",
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
                                        setState(() {
                                          categorie = ActionES(
                                              email: emailController.text,
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
  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: categorie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>MyApp()));
        } else if (snapshot.hasError) {
          return Text("Eror");
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
