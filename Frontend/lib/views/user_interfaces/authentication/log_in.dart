import 'package:e_commerce/controllers/login_provider.dart';
import 'package:e_commerce/models/auth/login_model.dart';
import 'package:e_commerce/views/components/appstyle.dart';
import 'package:e_commerce/views/components/custom_field.dart';
import 'package:e_commerce/views/components/reusable_text.dart';
import 'package:e_commerce/views/user_interfaces/authentication/registration.dart';
import 'package:e_commerce/views/user_interfaces/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

   bool validation = false;

  void formValidation(){
    if(email.text.isNotEmpty && password.text.isNotEmpty){
      validation = true;
    }else{
      validation=false;
    }
  }
  @override
  Widget build(BuildContext context) {

    var loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: 0.5, image: AssetImage("assets/images/bg.jpg"))),
        child: ListView(
          children: [
            ReusableText(
                text: "Welcome",
                style: appstyle(30, Colors.white, FontWeight.w600)),
            ReusableText(
                text: "Login Into Your Account",
                style: appstyle(15, Colors.white, FontWeight.normal)),
            SizedBox(height: 50.h),
            CustomField(
              keyboard: TextInputType.emailAddress,
              hintText: "Enter Email",
              controller: email,
              prefixIcon: Icon(
                Icons.mail_outline,
                size: 25,
              ),
              validator: (email) {
                if(email!.isEmpty && !email.contains("@")){
                  return "Please Enter Valid Email";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 15.h),
            CustomField(
              hintText: "Enter Password",
              controller: password,
              obscureText: loginProvider.isObsecure,
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                size: 25,
              ),
              suffixIcon: GestureDetector(
                onTap: (){
                  loginProvider.isObsecure = !loginProvider.isObsecure;
                },
                child:loginProvider.isObsecure ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
              ),
              validator: (password) {
                if(password!.isEmpty || password.length<7){
                  return "Password must be contains 7 letter";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: FractionalOffset.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Registration()));
                },
                child: ReusableText(
                    text: "Register",
                    style: appstyle(15, Colors.white, FontWeight.normal)),
              ),
            ),
            SizedBox(height: 40.h),
            GestureDetector(
              onTap: () {
                formValidation();
                if(validation){
                  LoginModel model =LoginModel(email: email.text , password: password.text);
                  loginProvider.userLogin(model).then((response){
                    if(response==true){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                    }else{
                      print("Failed To LoggedIn");
                    }
                  });
                }else{
                  print("form is not validated");
                }
              },
              child: Container(
                height: 55.h,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: ReusableText(
                        text: "L O G I N",
                        style: appstyle(18, Colors.black, FontWeight.bold))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
