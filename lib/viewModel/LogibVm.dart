import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/productsModel.dart';
import '../Login.dart';
import '../home.dart';

class LoginVm with ChangeNotifier {
  LoginVm({required this.connect, required this.admin});

  bool connect;
  bool admin;

  void upDateSharedPreferences(String token, int id, role) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', token);
    _prefs.setString('role', role);
    _prefs.setInt('id', id);
  }

  Future login({
    context,
    required String email,
    required String password,
  }) async {
    final request = await http.MultipartRequest("POST", Uri.parse('http://$link/api/login'));
    request.fields['email'] = email;
    request.fields['password'] = password;

   await request.send().then((result) async{
      http.Response.fromStream(result)
          .then((response) {
        var statut = response.statusCode;
        print("statut reel ${statut}");
        if (statut == 200) {
          final user = userFromJson(response.body);
          upDateSharedPreferences(user.token, user.data.id, user.data.role);
          connecter();
        }
      });
    });

  }

  Future<void> connecter() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var role = _prefs.get("role");
    if (_prefs.containsKey("token")) {
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
}
