import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:jery/Admin/ListesUsers.dart';
import 'package:jery/Crud.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Admin/CommandesList.dart';
import 'global.dart';
class Remote{
final link=url;


  Future<List<Products>?> getProducts() async {
    var url = 'http://$link/api/products';
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final body = response.data;
      return productsFromJson(body);
    }
    else Exception("eureur");
  }
Future<List<Products>?> getProductsByCategorie(idCategorie) async {
  var url = 'http://$link/api/products?categorie_id=$idCategorie';
  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    compact: false,
  ));
  final response = await dio.get(url);

  if (response.statusCode == 200) {
    final body = response.data;
    return productsFromJson(body);
  }
  else Exception("eureur");
}

  Future<List<Categories>?> getCategories() async {
    var url = 'http://$link/api/categories';
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final body = response.data;
      return categoriesFromJson(body);
    }
    else Exception("eureur");
  }

  Future<List<Commandes>?> getCommandes() async {
    var url = 'http://$link/api/commandes';
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final body = response.data;
      return commandesFromJson(body);
    }
    else Exception("eureur");

  }

  Future<List<Users>?> getUsers() async {
    var url = 'http://$link/api/users';
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final body = response.data;
      return usersFromJson(body);
    }
    else Exception("eureur");
  }

}
