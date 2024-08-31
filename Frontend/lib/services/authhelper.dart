import 'dart:convert';
import 'package:e_commerce/models/auth/login_model.dart';
import 'package:e_commerce/models/auth/signup_model.dart';
import 'package:e_commerce/models/auth_response/login_res_model.dart';
import 'package:e_commerce/models/auth_response/profile_model.dart';
import 'package:e_commerce/services/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = http.Client();

  Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeader = {"Content-type": "application/json"};

    var url = Uri.http(Config.apiUrl, Config.loginUrl);

    var response = await client.post(url,
        headers: requestHeader, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String userToken = loginResponseModelFromJson(response.body).token;
      String userId = loginResponseModelFromJson(response.body).id;

      await prefs.setString('token', userToken);
      await prefs.setString('userId', userId);
      await prefs.setBool('isLoggedIn', true);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> signup(SignupModel model) async {
    Map<String, String> requestHeader = {"Content-type": "application/json"};

    var url = Uri.http(Config.apiUrl, Config.signupUrl);

    var response = await client.post(url,
        headers: requestHeader, body: jsonEncode(model.toJson()));

    if (response.statusCode == 201) {
      print(response.statusCode);
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }


  Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken=await prefs.getString('token');
    if (userToken == null) {
      print('Token not found');
      SnackBar(content: Text("Token Not Found"));
    }

    Map<String, String> requestHeader = {
      "Content-type": "application/json",
      "token":"Bearer $userToken"
    };

    var url = Uri.http(Config.apiUrl, Config.getUserUrl);
    var response = await client.get(url, headers: requestHeader);
    if (response.statusCode == 200) {
      var profile = profileResFromJson(response.body);
      return profile;
    } else {
      print(response.statusCode);
      throw "Failed To Get Profile";
    }
  }
}
