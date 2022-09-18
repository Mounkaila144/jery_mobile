// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  Products({
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
  dynamic code;
  dynamic type;
  dynamic barcodeSymbology;
  int categorieId;
  dynamic cost;
  dynamic margeDetail;
  dynamic margeGros;
  dynamic remiseDetail;
  dynamic prixMinDetail;
  dynamic remiseGros;
  dynamic prixMinGros;
  dynamic price;
  dynamic qty;
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
  DateTime createdAt;
  DateTime updatedAt;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
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
    image: json["image"] == null ? null : json["image"],
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
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "image": image == null ? null : image,
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);


List<Categories> categoriesFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  Categories({
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

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
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
