import 'dart:convert';
import 'package:e_commerce/models/cart/add_to_cart.dart';
import 'package:e_commerce/models/cart/get_products.dart';
import 'package:e_commerce/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class CartHelper {

  static var client = http.Client();
  Future<bool> addToCart(AddToCart model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken=await prefs.getString('token');
    Map<String, String> requestHeader = {
      "Content-type": "application/json",
      "token":"Bearer $userToken"
    };

    var url = Uri.http(Config.apiUrl, Config.addCartUrl);
    var response = await client.post(url, headers: requestHeader,body: jsonEncode(model.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Product>> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken=await prefs.getString('token');
    Map<String, String> requestHeader = {
      "Content-type": "application/json",
      "token":"Bearer $userToken"
    };

    var url = Uri.http(Config.apiUrl, Config.getCartUrl);
    var response = await client.get(url, headers: requestHeader);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Product> cart=[];

      var products= jsonData[0]['products'];

      cart=List<Product>.from(products.map((product)=>Product.fromJson(product)));
      return cart;
    } else {
      throw Exception("Not Getting Cart");
    }
  }

  Future<bool> deleteItem(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken=await prefs.getString('token');
    Map<String, String> requestHeader = {
      "Content-type": "application/json",
      "token":"Bearer $userToken"
    };

    var url = Uri.http(Config.apiUrl,"${ Config.addCartUrl}/$id");
    var response = await client.delete(url, headers: requestHeader);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}