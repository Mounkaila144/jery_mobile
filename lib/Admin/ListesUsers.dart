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

enum MenuPop { itemOne, itemTwo, itemThree, itemFour }
// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.emailVerifiedAt,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String role;
  String email;
  dynamic emailVerifiedAt;
  String password;
  DateTime createdAt;
  DateTime updatedAt;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    name: json["name"],
    role: json["role"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    password: json["password"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "password": password,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class ListesUsers extends StatefulWidget {

  const ListesUsers({Key? key}) : super(key: key);

  @override
  State<ListesUsers> createState() => _ListesUsersState();
}

class _ListesUsersState extends State<ListesUsers> {
  final link=url;
  String _selectedMenu = '';
  late Future <List<Users>?> users;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }


  getData() async {
    users =  Remote().getUsers();
    if (users != null) {
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
  //   var url = 'https://${link}/api/users/$id_article';
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
  //           builder: (context) => ListesUsers(id: id))):
  //   Navigator.push(context,
  //       MaterialPageRoute(
  //           builder: (context) => Text("eror")));
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Users"),
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
        FutureBuilder<List<Users>?>(
          future: users,
          builder: (context,snap){
            if(snap.hasData){
              List<Users>? data=snap.data!;
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
                                            text: 'Nom: ',
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade800,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  '${data[index].name}\n',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ]),
                                      ),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: 'email: ',
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade800,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  '${data[index].email}\n',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ]),
                                      ),
                                      RichText(
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: 'cree a : ',
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



PopupMenuItem<MenuPop> Iteme(vauleIteme, IconData icon, Color color, String text) {
  return PopupMenuItem<MenuPop>(
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
