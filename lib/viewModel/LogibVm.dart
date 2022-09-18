import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/productsModel.dart';
import '../Login.dart';
import '../home.dart';

class LoginVm with ChangeNotifier {
  LoginVm({required this.connect,required this.admin});
  bool connect;
  bool admin;
  Future<User> login({
    required String email,
    required String password,
  }) async {
    var formData ={
      'email': email,
      'password': password
    };
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
        print("bbbbbbbbbbbbbbbbbb${statusType}");
        this.connect=true;

        final user = userFromJson(response.data);
       await user.data.role=="admin"?this.admin=true:this.admin=false;
        notifyListeners();
        return user;
      case 401:
        throw Exception('Identifiant invalide');
      default:
        throw Exception('Error contacting the server!');
    }
  }



}