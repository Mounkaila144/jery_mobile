import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jery/service.dart';
import 'package:jery/theme.dart';
import 'package:jery/viewModel/productsVm.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Admin/cart_model.dart';
import 'Crud.dart';
import 'FadeAnimation.dart';
import 'Login.dart';
import 'global.dart';
import 'home.dart';

class MenuHome extends StatefulWidget {
  const MenuHome({Key? key}) : super(key: key);

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
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
    return Container(
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
                              child:CachedNetworkImage(
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Center(child: LoadingBouncingLine.circle(
                                      borderColor: Colors.black,
                                      borderSize: 3.0,
                                      backgroundColor: Colors.white,
                                      duration: Duration(milliseconds: 500),
                                    ),
                                    ),
                                imageUrl: "http://${url}/${data[index].image}",
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
    );
  }
}
