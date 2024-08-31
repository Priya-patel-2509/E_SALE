import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controllers/cart_provider.dart';
import 'package:e_commerce/models/cart/get_products.dart';
import 'package:e_commerce/models/orders/confirm_order.dart';

import 'package:e_commerce/services/cart_helper.dart';
import 'package:e_commerce/services/order_helper.dart';
import 'package:e_commerce/views/components/appstyle.dart';
import 'package:e_commerce/views/components/checkout_btn.dart';
import 'package:e_commerce/views/user_interfaces/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  List<dynamic> cart = [];
  late Future<List<Product>> _cartList;
  Razorpay razorpay=Razorpay();
  @override
  void initState() {
    _cartList = CartHelper().getCart();
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  },
                  child: const Icon(
                    AntDesign.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "My Cart",
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: FutureBuilder(
                      future: _cartList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (snapshot.hasError) {
                          return Container(
                              width: 200,
                              child: Text("Error Failed To Get Cart"));
                        } else {
                          final cartData = snapshot.data;
                          return cartData == null || cartData.isEmpty
                              ? Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      "assets/json/empty_cart.json",
                                      controller: _controller,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Your Cart Is Empty",
                                      style: appstyle(
                                          15, Colors.black, FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Go ahead and explore top categories",
                                      style: appstyle(
                                          15, Colors.black, FontWeight.normal),
                                    )
                                  ],
                                ))
                              : ListView.builder(
                                  itemCount: cartData.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    final data = cartData[index];
                                    return GestureDetector(
                                      onTap: () {
                                        cartProvider.productIndex = index;
                                        print(index);
                                        cartProvider.checkOut.insert(0, data);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Slidable(
                                            key: const ValueKey(0),
                                            endActionPane: ActionPane(
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  flex: 1,
                                                  onPressed: (context) async {
                                                    await CartHelper()
                                                        .deleteItem(data.id)
                                                        .then((response) {
                                                      if (response == true) {
                                                        Navigator.pop(context);
                                                      } else {
                                                        print(
                                                            "Failed To Delete Item");
                                                      }
                                                    });
                                                  },
                                                  backgroundColor:
                                                      const Color(0xFF000000),
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.delete,
                                                  label: 'Delete',
                                                ),
                                              ],
                                            ),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.11,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors
                                                            .grey.shade500,
                                                        spreadRadius: 5,
                                                        blurRadius: 0.3,
                                                        offset:
                                                            const Offset(0, 1)),
                                                  ]),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Stack(
                                                          children: [
                                                            CachedNetworkImage(
                                                              imageUrl: data
                                                                  .cartItem
                                                                  .imageUrl[0],
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit.fill,
                                                            ),
                                                            Positioned(
                                                              bottom: -2,
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: SizedBox(
                                                                  height: 30.h,
                                                                  width: 30.w,
                                                                  child: cartProvider
                                                                              .productIndex ==
                                                                          index
                                                                      ? Icon(
                                                                          Feather
                                                                              .check_square,
                                                                          size:
                                                                              20,
                                                                          color:
                                                                              Colors.green,
                                                                        )
                                                                      : Icon(
                                                                          Feather
                                                                              .square,
                                                                          size:
                                                                              20,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 12,
                                                                left: 20),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                data.cartItem
                                                                    .name,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis)),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              data.cartItem
                                                                  .category,
                                                              style: appstyle(
                                                                  14,
                                                                  Colors.grey,
                                                                  FontWeight
                                                                      .w600),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "₹ ${data.cartItem.price}",
                                                                  style: appstyle(
                                                                      18,
                                                                      Colors
                                                                          .black,
                                                                      FontWeight
                                                                          .w600),
                                                                ),
                                                                const SizedBox(
                                                                  width: 20,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          16))),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    cartProvider
                                                                        .decrement();
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    AntDesign
                                                                        .minussquare,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .grey,
                                                                  )),
                                                              Text(
                                                                cartProvider
                                                                    .counter
                                                                    .toString(),
                                                                style: appstyle(
                                                                  16,
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .w600,
                                                                ),
                                                              ),
                                                              InkWell(
                                                                  onTap: () {
                                                                    cartProvider
                                                                        .increment();
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    AntDesign
                                                                        .plussquare,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .black,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      // ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                        }
                      }),
                )
              ],
            ),
            cartProvider.checkOut.isNotEmpty
                ?  Align(
                    alignment: Alignment.bottomCenter,
                    child: CheckoutButton(
                        onTap: () async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          String? userId = prefs.getString('userId') ?? "";
                          ConfirmModel model = ConfirmModel(
                              userId: userId,
                              image: cartProvider.checkOut[0].cartItem.imageUrl.toString(),
                              name: cartProvider.checkOut[0].cartItem.name,
                              productId: cartProvider.checkOut[0].cartItem.id,
                              quantity: 1,
                              deliveryStatus: "Pending",
                              paymentStatus: "SuccessFull",
                              total: cartProvider.checkOut[0].cartItem.price);
                          var options = {
                            'key': "rzp_test_owPVyKQdCDBPlr",
                            'amount': cartProvider.checkOut[0].cartItem.price,
                            'currency': 'INR',
                            'name': cartProvider.checkOut[0].cartItem.name,
                            'description': cartProvider.checkOut[0].cartItem.category,
                            'prefill': {
                              'contact': '6351638146',
                              'email': 'pateljainish2884@gmail.com'
                            }
                          };
                          razorpay.open(options);
                          OrderHelper().addToCart(model);
                        },
                        label: "Proceed to Checkout"),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
  void doNothing(BuildContext context) {}
  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    Fluttertoast.showToast(msg: "Order Created Successfully");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Order Denied");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
  @override
  void dispose() {
    _controller.dispose();
    razorpay.clear();
    super.dispose();
  }
}
