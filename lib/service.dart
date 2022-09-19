
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:jery/Admin/ListesUsers.dart';
import 'package:jery/Crud.dart';
import 'package:jery/viewModel/LogibVm.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Admin/CommandesList.dart';
import 'global.dart';
class Remote{
final link=url;
  static final HttpWithMiddleware https =
  HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  Future<List<Products>?> getProducts() async {
    var url = 'http://$link/api/products';
       final response = await https.get(Uri.parse(url), headers:buildHeaders());

    if (response.statusCode == 200) {
      final body = response.body;
      return productsFromJson(body);
    }
    else Exception("eureur");
  }
Future<List<Products>?> getProductsByCategorie(idCategorie) async {
  var url = 'http://$link/api/products?categorie_id=$idCategorie';
  final response = await https.get(Uri.parse(url), headers:buildHeaders());
  if (response.statusCode == 200) {
    final body = response.body;
    return productsFromJson(body);
  }
  else Exception("eureur");
}

  Future<List<Categories>?> getCategories(context) async {
    var url = 'http://$link/api/categories';
    
       final response = await https.get(Uri.parse(url), headers:buildHeaders());

    if (response.statusCode == 200) {
      final body = response.body;
      return categoriesFromJson(body);
    }
    else Exception("eureur");
  }

  Future<List<Commandes>?> getCommandes() async {
    var url = 'http://$link/api/commandes';
    
       final response = await https.get(Uri.parse(url), headers:buildHeaders());

    if (response.statusCode == 200) {
      final body = response.body;
      return commandesFromJson(body);
    }
    else Exception("eureur");

  }

  Future<List<Users>?> getUsers() async {
    var url = 'http://$link/api/users';
    
       final response = await https.get(Uri.parse(url), headers:buildHeaders());

    if (response.statusCode == 200) {
      final body = response.body;
      return usersFromJson(body);
    }
    else Exception("eureur");
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
}
