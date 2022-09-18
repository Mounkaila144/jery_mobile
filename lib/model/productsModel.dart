

import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Products {
  Products({
     required this.id,
     required this.name,
     this.code,
     this.type,
     this.barcodeSymbology,
     required this.categorieId,
     this.cost,
     this.margeDetail,
     this.margeGros,
     this.remiseDetail,
     this.prixMinDetail,
     this.remiseGros,
     this.prixMinGros,
     required this.price,
     required this.qty,
     this.alertQuantity,
     this.promotion,
     this.promotionPrice,
     this.startingDate,
     this.lastDate,
     required this.image,
     this.file,
     this.isVariant,
     this.featured,
     this.productList,
     this.qtyList,
     this.priceList,
     this.productDetails,
     this.isActive,
     this.isStockable,
     this.prixgros,
     this.createdAt,
     this.updatedAt,
  });

  int? id;
  String name;
  String? code;
  String? type;
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

final prds = [
  {
    "name": "ABCD",
    "image":
    "https://lapntab.com/storage/app/public/images/products/oppo-a12_1.jpg"
  },
  {
    "name": "QQWE",
    "image":
    "https://lapntab.com/storage/app/public/images/products/oppo-f15_1.jpg"
  },
  {
    "name": "WWSA",
    "image":
    "https://lapntab.com/storage/app/public/images/products/reno-5_1.jpg"
  },
  {
    "name": "EXMP",
    "image":
    "https://lapntab.com/storage/app/public/images/products/apple-iphone-11-pro-64gb_1.jpg"
  },
  {
    "name": "SADS",
    "image":
    "https://lapntab.com/storage/app/public/images/products/hp-envy-13-ah1011tx-8th-gen_1.jpg"
  },
  {
    "name": "SADS",
    "image":
    "https://lapntab.com/storage/app/public/images/products/hp-pavilion-15-cs1034tx-i7_1.jpg"
  },
];