import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../../Crud.dart';
import '../../FadeAnimation.dart';
import '../../service.dart';
import '../../theme.dart';
import '../../viewModel/productsVm.dart';
import '../widgets/cartCounter.dart';
import '../widgets/productsIteme.dart';
import 'cart.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future <List<Products>?> products;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    products = Remote().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Padding(
              padding:
              const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Icon(Icons.shopping_cart_rounded,
                          color: Colors.blue, size: 25)),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Consumer<ProductsVM>(
                      builder: (context, value, child) => CartCounter(
                        count: value.lst.length.toString(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.menu_rounded, color: Colors.blue, size: 25),
        ),
        title: Center(
          child: Text(
            "My Mart",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
      body: FutureBuilder <List<Products>?>(
        future: products,
        builder: (context,snap){
          if(snap.hasData){
            List<Products>? data=snap.data!;
            return
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) =>
                    ProductItem(
                      screenSize: screenSize,
                      image: data[index].image,
                      itemName: data[index].name,
                      categorieId: data[index].categorieId,
                      price: data[index].price,
                      qty: data[index].qty,
                      id: data[index].id,
                    ),
              );
          }
          else if(snap.hasError){
            return
              themejolie(
                donner: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      FadeAnimation(1, Text("${snap.error.toString()}", style: TextStyle(color: Colors.white, fontSize: 30),))
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
                              child: Text("Recharger la page", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
          return themejolie(donner: Center(
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
      ),
    );
  }
}
