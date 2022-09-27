import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jery/Admin/CategorieAdd.dart';
import 'package:jery/CategorieList.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../FadeAnimation.dart';
import '../global.dart';
import '../theme.dart';
import 'Dropdown.dart';



class AddOneCategories extends StatefulWidget {
  const AddOneCategories({Key? key}) : super(key: key);

  @override
  State<AddOneCategories> createState() => AddOneCategoriesState();
}
// To parse this JSON data, do

Categorie categorieFromJson(String str) => Categorie.fromJson(json.decode(str));

String categorieToJson(Categorie data) => json.encode(data.toJson());

class Categorie {
  Categorie({
    required this.id,
    required this.name,
    required this.image,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String image;
  String isActive;
  DateTime createdAt;
  DateTime updatedAt;

  factory Categorie.fromJson(Map<String, dynamic> json) => Categorie(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "is_active": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class AddOneCategoriesState extends State<AddOneCategories> {
   Future<Categorie>? categorie;
   final link=url;
  static final HttpWithMiddleware https =
  HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

   final List<String> items = [
     "Oui","Non"
   ];
   String selectedValue="Oui";


   @override
  void initState() {
    super.initState();
  }



   Future<Categorie> ActionES({
     required String nom,
     required String active,
     required XFile? photo,
   }) async {
     Map<String, String> headers = {
       "Accept": "application/json",
       "Content-Type": "application/json",
     };
    var image =File(photo!.path);

     final request = await http.MultipartRequest("POST", Uri.parse('http://$link/api/categories'));
     request.fields['name'] = nom;
     request.fields['is_active'] = active;
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
               builder: (context) =>CategoriesAdd()));
       return categorieFromJson(body);
     } else {
       Navigator.push(
           context,
           MaterialPageRoute(
               builder: (context) =>AddOneCategories()));
       throw Exception("eureur");
     }
   }

  final ImagePicker _picker = ImagePicker();
  late final XFile? image;
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
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
                        "Ajouter un Categories",
                        style: TextStyle(color: Colors.white, fontSize: 30),
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
                                "Valeur nvalide",
                                style: TextStyle(
                                    color: Colors.red.shade900,
                                    fontSize: 25),
                              ))
                              :
                          FadeAnimation(
                              1000,
                              Text(
                                "Entrer le nom et l'image ",
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
                                              "Votre nom est inferieur à 3"),
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


                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(
                                    'Oui ou nom',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme
                                          .of(context)
                                          .hintColor,
                                    ),
                                  ),
                                  items: items
                                      .map((item) =>
                                      DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value as String;
                                    });
                                  },
                                  buttonHeight: 40,
                                  buttonWidth: 140,
                                  itemHeight: 40,
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
                                             nom: nomController.text,
                                             active: selectedValue);
                                       });
                                      } else {
                                        setState(() {
                                          valide = true;
                                        });
                                      }
                                    },
                                    child: Text(
                                      "Ajouter",
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
  FutureBuilder<Categorie> buildFutureBuilder() {
    return FutureBuilder<Categorie>(
      future: categorie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          toast("Ajouter avec Success", Colors.green);
        }
        else if (snapshot.hasError) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>AddOneCategories()));
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
