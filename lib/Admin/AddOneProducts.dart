import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
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


Producs producsFromJson(String str) => Producs.fromJson(json.decode(str));

String producsToJson(Producs data) => json.encode(data.toJson());

class Producs {
  Producs({
    required this.id,
    required this.name,
    required this.code,
    required this.type,
    required this.barcodeSymbology,
    required this.categorieId,
    required this.cost,
    required this.margeDetail,
    required this.margeGros,
    required this.remiseDetail,
    required this.prixMinDetail,
    required this.remiseGros,
    required this.prixMinGros,
    required this.price,
    required this.qty,
    required this.alertQuantity,
    required this.promotion,
    required this.promotionPrice,
    required this.startingDate,
    required this.lastDate,
    required this.image,
    required this.file,
    required this.isVariant,
    required this.featured,
    required this.productList,
    required this.qtyList,
    required this.priceList,
    required this.productDetails,
    required this.isActive,
    required this.isStockable,
    required this.prixgros,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String code;
  String type;
  dynamic barcodeSymbology;
  int categorieId;
  dynamic cost;
  dynamic margeDetail;
  dynamic margeGros;
  dynamic remiseDetail;
  dynamic prixMinDetail;
  dynamic remiseGros;
  dynamic prixMinGros;
  String price;
  int qty;
  dynamic alertQuantity;
  dynamic promotion;
  dynamic promotionPrice;
  dynamic startingDate;
  dynamic lastDate;
  String image;
  dynamic file;
  dynamic isVariant;
  dynamic featured;
  dynamic productList;
  dynamic qtyList;
  dynamic priceList;
  dynamic productDetails;
  dynamic isActive;
  dynamic isStockable;
  dynamic prixgros;
  dynamic createdAt;
  dynamic updatedAt;

  factory Producs.fromJson(Map<String, dynamic> json) => Producs(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    type: json["type"],
    barcodeSymbology: json["barcode_symbology"],
    categorieId: json["categorie_id"],
    cost: json["cost"],
    margeDetail: json["marge_detail"],
    margeGros: json["marge_gros"],
    remiseDetail: json["remise_detail"],
    prixMinDetail: json["prix_min_detail"],
    remiseGros: json["remise_gros"],
    prixMinGros: json["prix_min_gros"],
    price: json["price"],
    qty: json["qty"],
    alertQuantity: json["alert_quantity"],
    promotion: json["promotion"],
    promotionPrice: json["promotion_price"],
    startingDate: json["starting_date"],
    lastDate: json["last_date"],
    image: json["image"],
    file: json["file"],
    isVariant: json["is_variant"],
    featured: json["featured"],
    productList: json["product_list"],
    qtyList: json["qty_list"],
    priceList: json["price_list"],
    productDetails: json["product_details"],
    isActive: json["is_active"],
    isStockable: json["is_stockable"],
    prixgros: json["prixgros"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "type": type,
    "barcode_symbology": barcodeSymbology,
    "categorie_id": categorieId,
    "cost": cost,
    "marge_detail": margeDetail,
    "marge_gros": margeGros,
    "remise_detail": remiseDetail,
    "prix_min_detail": prixMinDetail,
    "remise_gros": remiseGros,
    "prix_min_gros": prixMinGros,
    "price": price,
    "qty": qty,
    "alert_quantity": alertQuantity,
    "promotion": promotion,
    "promotion_price": promotionPrice,
    "starting_date": startingDate,
    "last_date": lastDate,
    "image": image,
    "file": file,
    "is_variant": isVariant,
    "featured": featured,
    "product_list": productList,
    "qty_list": qtyList,
    "price_list": priceList,
    "product_details": productDetails,
    "is_active": isActive,
    "is_stockable": isStockable,
    "prixgros": prixgros,
    "created_at": createdAt,
    "updated_at": updatedAt,
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
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path, filename:fileName),
      "name":nom,
      "categorie_id":id,
      "price":price,
      "qty":qty

    });
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    dio.options.headers["Content-Type"]="multipart/form-data";
    dio.options.headers["Accept"]="application/json";
    final response = await dio.post('http://$link/api/products', data: formData);
    var statut = response.statusCode;
    if (statut == 200) {
      return producsFromJson(response.data);
    } else {
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
                        "Connecter Vous",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Bienvenu",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
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
                              :
                          FadeAnimation(
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
                                              "La valeur est inferieur à 3"),
                                          FormBuilderValidators.required(
                                              errorText: "Valeur vide"),
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
                                          FormBuilderValidators.minLength(3,
                                              errorText:
                                              "La valeur est inferieur à 3"),
                                          FormBuilderValidators.required(
                                              errorText: "Valeur vide"),
                                        ]),
                                        controller: qtyController,
                                        decoration: InputDecoration(
                                            hintText: "quantité",
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>ProductsAdd(id: snapshot.data!.id )));
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
