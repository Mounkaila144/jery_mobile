import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jery/Crud.dart';

import 'package:jery/service.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../FadeAnimation.dart';
import '../global.dart';
import '../model/getOne.dart';
import '../theme.dart';
import '../view/widgets/cartIteme.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class CommandeContent extends StatefulWidget {
  final int id;

  const CommandeContent({Key? key,required this.id}) : super(key: key);

  @override
  State<CommandeContent> createState() => _CommandeContentState(this.id);
}

class _CommandeContentState extends State<CommandeContent> {
  final int id;
  late Future<List<Products>?> products;

final link=url;
  static final HttpWithMiddleware https =
  HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);
  String _selectedMenu = '';
  var isLoaded = false;

  _CommandeContentState(this.id,);

  @override
  void initState() {
    super.initState();
    getData(id);
  }
  getData(id){
    products=Remote().getCommande(id);
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
  //   
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
  //           builder: (context) => CommandeContent(id: id))):
  //   Navigator.push(context,
  //       MaterialPageRoute(
  //           builder: (context) => Text("eror")));
  // }


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
        title: Text("Contenue de la commandes"),
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
          future: products,
          builder: (context,snap){
            if(snap.hasData){
              return
                ResponsiveGridList(
                  horizontalGridMargin: 10,
                  verticalGridMargin: 10,
                  maxItemsPerRow: 1,
                  minItemWidth: 160,
                  shrinkWrap: true,
                  children: List.generate(
                    snap.data!.length==null?0:snap.data!.length,
                        (index) => InkWell(
                        onTap: () {

                        },
                        child:
                        CartItem(
                          screenSize: screenSize,
                          image: snap.data![index].image,
                          itemName: snap.data![index].name,
                          qty: snap.data![index].qty,
                          price: snap.data![index].price,
                        ),
                  ),
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
                        FadeAnimation(1, Text("${snap.error}", style: TextStyle(color: Colors.white, fontSize: 20),))
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
      )
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
