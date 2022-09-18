import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jery/Crud.dart';
import 'package:jery/Login.dart';
import 'package:jery/service.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FadeAnimation.dart';
import '../global.dart';
import '../theme.dart';
import 'CommandesList.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class CommandeRecus extends StatefulWidget {

  const CommandeRecus({Key? key}) : super(key: key);

  @override
  State<CommandeRecus> createState() => _CommandeRecusState();
}

class _CommandeRecusState extends State<CommandeRecus> {
  final link=url;
  String _selectedMenu = '';
  late Future <List<Commandes>?> articles;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }


  getData() async {
    articles =  Remote().getCommandes();
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
  //           builder: (context) => CommandeRecus(id: id))):
  //   Navigator.push(context,
  //       MaterialPageRoute(
  //           builder: (context) => Text("eror")));
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Commandes"),
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
                        builder: (context) =>Login()));
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
        FutureBuilder<List<Commandes>?>(
          future: articles,
          builder: (context,snap){
            if(snap.hasData){
              List<Commandes>? data=snap.data!;
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
                        Card(
                          color: Colors.blue.shade200,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 130,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: 'Envoyer par user n°: ',
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade800,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  '${data[index].userId}\n',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ]),
                                      ),
                                      RichText(
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: 'Date: ',
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade800,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  '${data[index].createdAt.toString()}\n',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
