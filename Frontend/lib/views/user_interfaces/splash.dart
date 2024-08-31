import 'dart:core';
import 'dart:async';
import 'package:e_commerce/views/user_interfaces/authentication/log_in.dart';
import 'package:e_commerce/views/user_interfaces/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }
  getPrefs()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn')?? false;
    if(loggedIn == true ){
      Timer(Duration(seconds: 3), (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));});
    }else{
      Timer(Duration(seconds: 3), (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Image.asset("assets/images/applogo.jpg",height: 200,width: 200,)),
    );
  }
}
