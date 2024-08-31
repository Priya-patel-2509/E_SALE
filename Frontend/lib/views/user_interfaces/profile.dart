import 'package:e_commerce/controllers/login_provider.dart';
import 'package:e_commerce/services/authhelper.dart';
import 'package:e_commerce/views/components/appstyle.dart';
import 'package:e_commerce/views/components/reusable_text.dart';
import 'package:e_commerce/views/components/tiles_widget.dart';
import 'package:e_commerce/views/user_interfaces/authentication/log_in.dart';
import 'package:e_commerce/views/user_interfaces/cartpage.dart';
import 'package:e_commerce/views/user_interfaces/favourite_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context);
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
                            FutureBuilder(
                              future: AuthHelper().getProfile(),
                              builder: (context,snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator
                                          .adaptive());
                                } else if (snapshot.hasError) {
                                  return Container(
                                      width: 200,
                                      child: Text("Error ${snapshot.error}"));
                                } else {
                                  final data=snapshot.data;
                                  return Container(
                                    height: 45.h,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        ReusableText(
                                            text: data?.username ?? "",
                                            style: appstyle(
                                                14, Colors.black,
                                                FontWeight.normal)),
                                        ReusableText(
                                            text: data?.email ?? "",
                                            style: appstyle(
                                                14, Colors.black,
                                                FontWeight.normal)),
                                      ],
                                    ),
                                  );
                                }
                              }
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Feather.edit,
                                size: 18,
                              )),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 170.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                              title: "Orders",
                              leading:
                                  MaterialCommunityIcons.truck_fast_outline,
                              OnTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Favourite()));
                              },
                            ),
                            TilesWidget(
                              title: "Favorites",
                              leading: MaterialCommunityIcons.heart_outline,
                              OnTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Favourite()));
                              },
                            ),
                            TilesWidget(
                              title: "Cart",
                              leading: Fontisto.shopping_bag_1,
                              OnTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartPage()));
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 110.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                              title: "Coupons",
                              leading: MaterialCommunityIcons.tag_outline,
                              OnTap: () {},
                            ),
                            TilesWidget(
                              title: "My Store",
                              leading: MaterialCommunityIcons.shopping_outline,
                              OnTap: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 170.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                              title: "Shipping Addresses",
                              leading: SimpleLineIcons.location_pin,
                              OnTap: () {},
                            ),
                            TilesWidget(
                              title: "Settings",
                              leading: AntDesign.setting,
                              OnTap: () {},
                            ),
                            TilesWidget(
                              title: "Logout",
                              leading: AntDesign.logout,
                              OnTap: () {
                                loginProvider.logout();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
