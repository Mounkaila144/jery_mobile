import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jery/main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/productsModel.dart';
import '../Login.dart';
import '../home.dart';

class LoginVm with ChangeNotifier {
  LoginVm({required this.connect, required this.admin, required this.name, required this.email});
  bool connect;
  bool admin;
  String name;
  String email;
  Future<void> set() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var role = _prefs.get("role");
    var name = _prefs.get("name");
    var email = _prefs.get("email");
    this.name="ghj";
    this.name="ghfh";
    notifyListeners();
  }

  void upDateSharedPreferences(String token, int id, role,email,name) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', token);
    _prefs.setString('role', role);
    _prefs.setString('email', email);
    _prefs.setString('name', name);
    _prefs.setInt('id', id);
  }

  Future<Article> login({
    context,
    required String email,
    required String password,
  }) async {
    final request = await http.MultipartRequest("POST", Uri.parse('http://$link/api/login'));
    request.fields['email'] = email;
    request.fields['password'] = password;

    var r=await request.send();
    var response=await http.Response.fromStream(r);
    final statusType = response.statusCode;
    print("statut ${response.statusCode}");

    switch (statusType) {
      case 200:
        Navigator.push(context, MaterialPageRoute(builder:
            (context)=>MyApp()));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Connexion Reussi'),
              duration: Duration(seconds: 4),
            ));
        final user = articleFromJson(response.body);
        upDateSharedPreferences(user.token, user.data.id, user.data.role,user.data.email,user.data.name,);
        connecter();

        return user;
      case 401:
        throw Exception('Identifiant invalide');
      default:
        throw Exception('Error contacting the server!');
    }
  }


  Future<void> connecter() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var role = _prefs.get("role");
    var name = _prefs.get("name");
    var email = _prefs.get("email");
    if (_prefs.containsKey("token")) {
      this.name=name.toString();
      this.email=email.toString();
      if (role == "admin") {
        this.admin = true;
        this.connect = false;
      } else {
        this.admin = false;
        this.connect = true;
      }
    } else {
      this.connect = false;
      this.admin = false;
    }
    notifyListeners();
  }
   void Email(){
    this.email;
    notifyListeners();
  }

}
