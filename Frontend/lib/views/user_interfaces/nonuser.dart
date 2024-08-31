import 'package:e_commerce/views/components/appstyle.dart';
import 'package:e_commerce/views/components/reusable_text.dart';
import 'package:e_commerce/views/user_interfaces/authentication/log_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE2E2E2),
        leading: Icon(
          Icons.qr_code,
          size: 20,
          color: Colors.black,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 750.h,
                decoration: BoxDecoration(color: Color(0xffE2E2E2)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 15, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  height: 50.h,
                                  width: 50.w,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/images/user.jpeg"),
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: ReusableText(
                                    text: "Please LogIn To Your Account",
                                    style: appstyle(
                                        14, Colors.grey.shade600, FontWeight.normal)),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                            },
                            child: Container(
                                margin: EdgeInsets.only(top: 5),
                                width: 60.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(
                                    child: ReusableText(
                                        text: "Login",
                                        style: appstyle(12, Colors.white,
                                            FontWeight.normal)))),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
