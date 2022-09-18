import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jery/main.dart';
import 'package:jery/theme.dart';
import 'package:jery/viewModel/LogibVm.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FadeAnimation.dart';
import 'Menu.dart';
import 'global.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();

}

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
    required this.token,
    required this.data,
  });

  String token;
  Data data;

  factory User.fromJson(Map<String, dynamic> json) => User(
    token: json["token"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.role,
  });

  int id;
  String role;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
  };
}

class LoginState extends State<Login> {
  final link=url;

  void upDateSharedPreferences(String token, int id,role) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', token);
    _prefs.setString('role', role);
    _prefs.setInt('id', id);
  }
  Future<User>? user;
  Future<String?> token(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    return token;
  }

  bool connect = false;

  void Connexion() {
    setState(() {
      connect = true;
    });
  }

  void Deconnexion() {
    setState(() async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.remove('token');
      await _prefs.remove('id');
    });
  }


  final _formKey = GlobalKey<FormState>();
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
        child: user==null?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Connecter Vous",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                    Text("Bonjour")
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
                                    "Votre mots de passe ou votre adress email est invalide",
                                    style: TextStyle(
                                        color: Colors.red.shade900,
                                        fontSize: 25),
                                  ))
                              :FadeAnimation(
                                      1000,
                                      Text(
                                        "Entrer votre Email et votre mots de passe",
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
                                        controller: emailController,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText: "Le champ est vide"),
                                          FormBuilderValidators.email(
                                              errorText:
                                                  "Votre Email n'est pas un email valide"),
                                        ]),
                                        decoration: InputDecoration(
                                            hintText: "Email or Phone number",
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
                                          FormBuilderValidators.minLength(6,
                                              errorText:
                                                  "Votre mot de passe est inferieur à 6"),
                                          FormBuilderValidators.required(
                                              errorText:
                                                  "Votre mot de passe est vide"),
                                        ]),
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                            hintText: "Password",
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
                                          user =Provider.of<LoginVm>(context,listen: false).login(
                                          email: emailController.text,
                                          password: passwordController.text);
                                        });
                                      } else {
                                        setState(() {
                                          valide = true;
                                        });
                                      }
                                    },
                                    child: Text(
                                      "Login",
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
    future: user,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        Navigator.push(context, MaterialPageRoute(builder:
                (context)=>MyApp()));

      } else if (snapshot.hasError) {
        return themejolie(
          donner: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                FadeAnimation(1, Text("${snapshot.error}", style: TextStyle(color: Colors.white, fontSize: 10),))
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