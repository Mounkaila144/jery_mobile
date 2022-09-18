import 'package:flutter/cupertino.dart';

import 'item_model.dart';

class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? initialPrice;
  final int? productPrice;
  final ValueNotifier<int>? quantity;
  final String? unitTag;
  final String? image;

  Cart(
      {required this.id,
        required this.productId,
        required this.productName,
        required this.initialPrice,
        required this.productPrice,
        required this.quantity,
        required this.unitTag,
        required this.image});

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        productId = data['productId'],
        productName = data['productName'],
        initialPrice = data['initialPrice'],
        productPrice = data['productPrice'],
        quantity = ValueNotifier(data['quantity']),
        unitTag = data['unitTag'],
        image = data['image'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity?.value,
      'unitTag': unitTag,
      'image': image,
    };
  }
}
List<Item> products = [
  Item(
      name: 'Apple', unit: 'Kg', price: 20, image: 'assets/images/apple.png'),
  Item(
      name: 'Mango',
      unit: 'Doz',
      price: 30,
      image: 'assets/images/mango.png'),
  Item(
      name: 'Banana',
      unit: 'Doz',
      price: 10,
      image: 'assets/images/banana.png'),
  Item(
      name: 'Grapes',
      unit: 'Kg',
      price: 8,
      image: 'assets/images/grapes.png'),
  Item(
      name: 'Water Melon',
      unit: 'Kg',
      price: 25,
      image: 'assets/images/watermelon.png'),
  Item(name: 'Kiwi', unit: 'Pc', price: 40, image: 'assets/images/kiwi.png'),
  Item(
      name: 'Orange',
      unit: 'Doz',
      price: 15,
      image: 'assets/images/orange.png'),
  Item(name: 'Peach', unit: 'Pc', price: 8, image: 'assets/images/peach.png'),
  Item(
      name: 'Strawberry',
      unit: 'Box',
      price: 12,
      image: 'assets/images/strawberry.png'),
  Item(
      name: 'Fruit Basket',
      unit: 'Kg',
      price: 55,
      image: 'assets/images/fruitBasket.png'),
];