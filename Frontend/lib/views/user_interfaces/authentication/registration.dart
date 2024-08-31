import 'package:e_commerce/controllers/login_provider.dart';
import 'package:e_commerce/models/auth/signup_model.dart';
import 'package:e_commerce/views/components/appstyle.dart';
import 'package:e_commerce/views/components/custom_field.dart';
import 'package:e_commerce/views/components/reusable_text.dart';
import 'package:e_commerce/views/user_interfaces/authentication/log_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController location = TextEditingController();


  bool validation = false;

  void formValidation(){
    if(email.text.isNotEmpty && password.text.isNotEmpty && username.text.isNotEmpty && location.text.isNotEmpty){
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
                text: "How Are You !!",
                style: appstyle(30, Colors.white, FontWeight.w600)),
            ReusableText(
                text: "Create Your Account",
                style: appstyle(15, Colors.white, FontWeight.normal)),
            SizedBox(height: 50.h),
            CustomField(
              keyboard: TextInputType.text,
              hintText: "Enter Username",
              controller: username,
              prefixIcon: Icon(
                MaterialCommunityIcons.account,
                size: 25,
              ),
              validator: (username) {
                if(username!.isEmpty){
                  return "Please Enter Username";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 15.h),
            CustomField(
              keyboard: TextInputType.visiblePassword,
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
                if(password!.isEmpty && password.length<7){
                  return "Password must be contains 7 letter";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 10.h),
            CustomField(
              keyboard: TextInputType.text,
              hintText: "Enter Address",
              controller: location,
              prefixIcon: Icon(
                MaterialCommunityIcons.account,
                size: 25,
              ),
              validator: (location) {
                if(location!.isEmpty){
                  return "Please Enter Username";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 15.h),
            Align(
              alignment: FractionalOffset.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: ReusableText(
                    text: "Login",
                    style: appstyle(15, Colors.white, FontWeight.normal)),
              ),
            ),
            SizedBox(height: 40.h),
            GestureDetector(
              onTap: () {
                formValidation();
                if(validation){
                  SignupModel model =SignupModel(username: username.text,email: email.text , password: password.text,location: location.text);
                  loginProvider.registerUser(model).then((response){
                    if(response==true){
                      print(model);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    }else{
                      print("Failed To SignUp");
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
                        text: "S I G N U P",
                        style: appstyle(18, Colors.black, FontWeight.bold))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
