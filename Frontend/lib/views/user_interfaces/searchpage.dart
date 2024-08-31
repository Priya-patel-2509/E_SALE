import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controllers/product_provider.dart';
import 'package:e_commerce/models/sneaker_model.dart';
import 'package:e_commerce/services/helper.dart';
import 'package:e_commerce/views/components/appstyle.dart';
import 'package:e_commerce/views/components/custom_field.dart';
import 'package:e_commerce/views/components/reusable_text.dart';
import 'package:e_commerce/views/user_interfaces/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _dataController;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
    _dataController =
    AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _dataController.dispose();
    super.dispose();
  }

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductNotifier>(context);
    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          backgroundColor: Colors.black,
          elevation: 0,
          title: CustomField(
            hintText: "Search For A Product",
            controller: search,
            onEditingComplete: () {
              setState(() {});
            },
            prefixIcon: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: const Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                )),
          ),
        ),
        body: search.text.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset("assets/json/search.json",
                      controller: _controller,
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.fill),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Search Something",
                    style: appstyle(15, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Find that suits you",
                    style: appstyle(15, Colors.black, FontWeight.normal),
                  )
                ],
              ))
            : FutureBuilder<List<Sneakers>>(
                future: Helper().search(search.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: ReusableText(
                            text: "Error in Retriving data",
                            style:
                                appstyle(20, Colors.black, FontWeight.bold)));
                  } else if (snapshot.data!.isEmpty) {
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/json/nodata.json",
                                controller: _controller,
                                height: MediaQuery.of(context).size.height * 0.3,
                                fit: BoxFit.fill),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "No Data Found!",
                              style: appstyle(15, Colors.black, FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Try Something Different",
                              style: appstyle(15, Colors.black, FontWeight.normal),
                            )
                          ],
                        ));
                  } else {
                    final shoe = snapshot.data;
                    return ListView.builder(
                        itemCount: shoe!.length,
                        itemBuilder: (context, index) {
                          final shoeData = shoe[index];
                          return GestureDetector(
                            onTap: () {
                              productProvider.shoesSizes = shoeData.sizes;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductPage(sneaker: shoeData)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Container(
                                    height: 125.h,
                                    width: 325.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade500,
                                              spreadRadius: 5,
                                              blurRadius: 0.5,
                                              offset: const Offset(0, 1))
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.all(12.h),
                                                child: Container(
                                                  height: 100.h,
                                                  width: 100.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(12),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      12)),
                                                      image: DecorationImage(
                                                          image: CachedNetworkImageProvider(
                                                              shoeData
                                                                  .imageUrl[0]),
                                                          fit: BoxFit.cover)),
                                                )),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 12.h, left: 20.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ReusableText(
                                                      text: shoeData.name,
                                                      style: appstyle(
                                                          16,
                                                          Colors.black,
                                                          FontWeight.bold)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  ReusableText(
                                                      text: shoeData.category,
                                                      style: appstyle(
                                                          14,
                                                          Colors.grey,
                                                          FontWeight.bold)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("₹${shoeData.oldPrice}",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.red,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          decorationStyle: TextDecorationStyle.solid,
                                                        decorationThickness: 2
                                                      )),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  ReusableText(
                                                      text:
                                                          "₹ Offer Price:${shoeData.price}",
                                                      style: appstyle(
                                                          16,
                                                          Colors.green,
                                                          FontWeight.bold)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        });
                  }
                }));
  }
}
