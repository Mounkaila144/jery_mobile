import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<User> login({
    context,
    required String email,
    required String password,
  }) async {
    var formData = {'email': email, 'password': password};
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    final response = await dio.post("http://$link/api/login", data: formData);
    // var statut = response.statusCode;
    // if (statut == 20) {
    //   return (response.data);
    // } else {
    //   throw Exception("eureur");
    // }

    final statusType = (response.statusCode);

    switch (statusType) {
      case 200:
        final user = userFromJson(response.data);
        upDateSharedPreferences(user.token, user.data.id, user.data.role);
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
