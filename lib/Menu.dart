import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jery/Admin/AddUsers.dart';
import 'package:jery/Admin/CategorieAdd.dart';
import 'package:jery/CategorieList.dart';
import 'package:jery/service.dart';
import 'package:jery/theme.dart';
import 'package:jery/view/screen/Iconcart.dart';
import 'package:jery/view/screen/cart.dart';
import 'package:jery/view/widgets/Sidebar.dart';
import 'package:jery/viewModel/LogibVm.dart';
import 'package:jery/viewModel/productsVm.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Crud.dart';
import 'FadeAnimation.dart';
import 'Login.dart';
import 'home.dart';
import 'view/widgets/cartCounter.dart';

class Menu extends StatefulWidget {

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
    return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Menu',
              ),
              backgroundColor: Colors.blue.shade900,
              actions:[
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
          ),
              ],
            ),
            drawer: Sidebar(),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blueAccent.shade100,
                    Colors.white,
                  ],
                ),
              ),
              child:
              FutureBuilder <List<Products>?>(
                future: products,
                builder: (context,snap){
                  if(snap.hasData){
                    List<Products>? data=snap.data!;
                    return
                      ResponsiveGridList(
                        horizontalGridMargin: 10,
                        verticalGridMargin: 10,
                        maxItemsPerRow: 3,
                        minItemWidth: 300,
                        shrinkWrap: true,
                        children: List.generate(
                          data.length==null?0:data.length,
                              (index) => InkWell(
                              onTap: () {},
                              child:
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.indigoAccent,
                                      Colors.indigo,
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        "http://${link}/${data[index].image}",
                                        // width: 120,height: 120,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      data[index].name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      data[index].price,
                                      style: TextStyle(
                                        color: Colors.yellow.shade800,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Consumer<ProductsVM>(
                                      builder: (context, value, child) =>
                                          ElevatedButton(onPressed:  () async {
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            bool connect=prefs.containsKey("token");
                                            if(connect) {
                                              value.add(data[index].image,
                                                  data[index].name,
                                                  data[index].qty,
                                                  data[index].price,
                                                  data[index].id,
                                                  data[index].categorieId);
                                             // Provider.of<ProductsVM>(context,listen: false).ajouter(data[index].price);
                                            }
                                            else
                                            Navigator.push(context, MaterialPageRoute(builder:
                                                (context)=>Login()));
                                          },
                                              child: Text("Ajouter au panier"))
                                    ),
                                  ],
                                ),
                              )),
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
            ),
          );
  }
}


