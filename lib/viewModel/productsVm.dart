import 'package:flutter/widgets.dart';

import '../../model/productsModel.dart';

class ProductsVM with ChangeNotifier {
  List<Products> lst = <Products>[];
  var panier =[];
  ProductsVM({required this.total});
  int total;
  add(String image, String name, int qty, String price, int id,int categorieId) {
    lst.add(Products(image: image, name: name, qty: qty, categorieId: categorieId, price: price, id: id));
    panier.add(id);
    Total();
    notifyListeners();
  }

  del(int index) {
    lst.removeAt(index);
    panier.removeAt(index);
    Total();
    notifyListeners();
  }

void Total(){
    var t=0;
    lst.forEach((element) {t+=int.parse(element.price);});
    this.total=t;
    notifyListeners();

}


  delAll() {
    lst.clear();
    panier.clear();
    this.total=0;
    notifyListeners();
  }

}