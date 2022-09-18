import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jery/Admin/AddOneProducts.dart';
import 'package:jery/Crud.dart';
import 'package:jery/Login.dart';
import 'package:jery/service.dart';
import 'package:jery/theme.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FadeAnimation.dart';
import '../global.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class ProductsAdd extends StatefulWidget {
  final int id;

  const ProductsAdd({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductsAdd> createState() => _ProductsAddState(this.id);
}

class _ProductsAddState extends State<ProductsAdd> {
  final link=url;
  String _selectedMenu = '';
  late Future <List<Products>?> articles;
  var isLoaded = false;
  final int id;

  _ProductsAddState(this.id);

  @override
  void initState() {
    super.initState();

    getData(id);
  }


  getData(idCategorie) async {
    articles =  Remote().getProductsByCategorie(idCategorie);
    if (articles != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }
  static Map<String, String> buildHeaders({String? accessToken}) {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  // Future Remove(int id_article) async {
  //   var url = 'https://${link}/api/articles/$id_article';
  //   Dio dio = Dio();
  //   dio.interceptors.add(PrettyDioLogger(
  //     requestHeader: true,
  //     requestBody: true,
  //     responseBody: true,
  //     responseHeader: false,
  //     compact: false,
  //   ));
  //   final response = await dio.delete(url);
  //   var status=response.statusCode;
  //   status ==204?
  //   Navigator.push(context,
  //       MaterialPageRoute(
  //           builder: (context) => ProductsAdd(id: id))):
  //   Navigator.push(context,
  //       MaterialPageRoute(
  //           builder: (context) => Text("eror")));
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Products"),
        actions: [
          Card(
            color: Colors.blue.shade900,
            shape: CircleBorder(),
            child: IconButton(
              icon: const Icon(
                Icons.add_circle,
                size: 30,
                color: Colors.orange,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddOneProducss(id: id)));
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body:
      Container(
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
        FutureBuilder<List<Products>?>(
          future: articles,
          builder: (context,snap){
            if(snap.hasData){
              List<Products>? data=snap.data!;
              return
                ResponsiveGridList(
                  horizontalGridMargin: 10,
                  verticalGridMargin: 10,
                  maxItemsPerRow: 3,
                  minItemWidth: 160,
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
                                  "http://${url}/${data[index].image}",
                                  // width: 120,height: 120,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                data[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // PopupMenuButton<Menu>(
                              //   // Callback that sets the selected popup menu item.
                              //     onSelected: (Menu item) async {
                              //       switch (item) {
                              //         case Menu.itemOne:
                              //         // TODO: Handle this case.
                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: (context) => editArticle(
                              //                     id: id,
                              //                     id_article: data[index].id,
                              //                     stock:data[index].stock,
                              //                     prix:data[index].prix,
                              //                     description:data[index].description,
                              //                     nom: data[index].nom,
                              //
                              //                   )));
                              //           break;
                              //         case Menu.itemTwo:
                              //         // TODO: Handle this case.
                              //
                              //           Remove(data[index].id);
                              //
                              //
                              //           break;
                              //
                              //         case Menu.itemThree:
                              //         // TODO: Handle this case.
                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: (context) => detailArticle(
                              //                     id: id,
                              //                     id_article: data[index].id,
                              //                     stock:data[index].stock,
                              //                     prix:data[index].prix,
                              //                     description:data[index].description,
                              //                     nom: data[index].nom,
                              //                     contentUrl: data[index].contentUrl,
                              //
                              //                   )));
                              //           break;
                              //         case Menu.itemFour:
                              //         // TODO: Handle this case.
                              //           Publier(data[index].id);
                              //           break;
                              //       }
                              //     },
                              //     itemBuilder: (BuildContext context) =>
                              //     <PopupMenuEntry<Menu>>[
                              //       Iteme(Menu.itemOne, Icons.edit, Colors.blue,
                              //           "Modifier"),
                              //       Iteme(Menu.itemTwo, Icons.highlight_remove,
                              //           Colors.red, "Suprimer"),
                              //       Iteme(Menu.itemThree, Icons.remove_red_eye,
                              //           Colors.green, "Details"),
                              //       Iteme(Menu.itemFour, Icons.send,
                              //           Colors.blue.shade900, "Publier"),
                              //     ]),
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
                        FadeAnimation(1, Text("Eureur   de chargement ", style: TextStyle(color: Colors.white, fontSize: 60),))
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
          }

        ),
      ),
    );
  }
}



PopupMenuItem<Menu> Iteme(vauleIteme, IconData icon, Color color, String text) {
  return PopupMenuItem<Menu>(
    value: vauleIteme,
    child: Row(
      children: [
        Icon(icon, color: color, size: 22),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.blue.shade900,
          ),
        ),
      ],
    ),
  );
}
