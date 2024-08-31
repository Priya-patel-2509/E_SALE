import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controllers/favorites_provider.dart';
import 'package:e_commerce/controllers/login_provider.dart';
import 'package:e_commerce/controllers/product_provider.dart';
import 'package:e_commerce/models/cart/add_to_cart.dart';
import 'package:e_commerce/models/constants.dart';
import 'package:e_commerce/models/sneaker_model.dart';
import 'package:e_commerce/services/cart_helper.dart';
import 'package:e_commerce/views/components/appstyle.dart';
import 'package:e_commerce/views/components/checkout_btn.dart';
import 'package:e_commerce/views/user_interfaces/authentication/log_in.dart';
import 'package:e_commerce/views/user_interfaces/favourite_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key,required this.sneaker});
  final Sneakers sneaker;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');
  final _favBox = Hive.box('fav_box');

  Future<void> _createFav(Map<String,dynamic> addFav) async {
    await _favBox.add(addFav);
    getFavorites();
  }

  getFavorites(){
    final favData = _favBox.keys.map((key){
      final item = _favBox.get(key);
      return {
        "key":key,
        "id": item["id"]
      };
    }).toList();

    favor = favData.toList();
    ids = favor.map((item)=> item['id']).toList();
    setState(() {
    });
  }
  Future<void> _createCart(Map<dynamic, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context,listen: true);
    favoritesNotifier.getFavorites();
    return Scaffold(
        body: Consumer<ProductNotifier>(
          builder: (context, productNotifier, child) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  leadingWidth: 0,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            productNotifier.shoeSizes.clear();
                          },
                          child: const Icon(
                            AntDesign.close,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  snap: false,
                  floating: true,
                  backgroundColor: Colors.transparent,
                  expandedHeight: MediaQuery.of(context).size.height,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.sneaker.imageUrl.length,
                              controller: pageController,
                              onPageChanged: (page) {
                                productNotifier.activePage = page;
                              },
                              itemBuilder: (context, int index) {
                                return Stack(
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.39,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width,
                                      color: Colors.grey.shade300,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        widget.sneaker.imageUrl[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        top: 56,
                                        right: 20,
                                        child: Consumer<FavoritesNotifier>(
                                          builder: (BuildContext context,favoritesNotifier,child) {
                                            return GestureDetector(
                                              onTap: () async{
                                                if(favoritesNotifier.ids.contains(widget.sneaker.id)){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Favourite()));
                                                }else{
                                                  _createFav({
                                                    "id":widget.sneaker.id,
                                                    "name":widget.sneaker.name,
                                                    "category":widget.sneaker.category,
                                                    "price":widget.sneaker.price,
                                                    "imageUrl":widget.sneaker.imageUrl[0]
                                                  });
                                                }
                                              },
                                              child: favoritesNotifier.ids.contains(widget.sneaker.id) ? const Icon (AntDesign.heart,color: Colors.red,): const Icon(AntDesign.hearto)
                                            );
                                          },

                                        )),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height: MediaQuery.of(context).size.height*0.3,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:
                                          List<Widget>.generate(
                                              widget.sneaker
                                                  .imageUrl.length,
                                                  (index) => Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    4),
                                                child:
                                                CircleAvatar(
                                                  radius: 5,
                                                  backgroundColor: productNotifier
                                                      .activepage !=
                                                      index
                                                      ? Colors
                                                      .grey
                                                      : Colors
                                                      .black,
                                                ),
                                              )),
                                        )),
                                  ],
                                );
                              }),
                        ),
                        Positioned(
                            bottom: 30,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              child: Container(
                                height:MediaQuery.of(context).size.height * 0.645,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.sneaker.name,
                                        style: appstyle(
                                            25,
                                            Colors.black,
                                            FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            widget.sneaker.category,
                                            style: appstyle(
                                                20,
                                                Colors.grey,
                                                FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          RatingBar.builder(
                                            initialRating: 4,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 22,
                                            itemPadding:
                                            const EdgeInsets.symmetric(horizontal: 1),
                                            itemBuilder: (context, _) =>
                                            const Icon(
                                              Icons.star,
                                              size: 18,
                                              color: Colors.black,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$${ widget.sneaker.price}",
                                            style: appstyle(
                                                20,
                                                Colors.black,
                                                FontWeight.w600),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Colors",
                                                style: appstyle(
                                                    18,
                                                    Colors.black,
                                                    FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const CircleAvatar(
                                                radius: 7,
                                                backgroundColor:
                                                Colors.black,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const CircleAvatar(
                                                radius: 7,
                                                backgroundColor:
                                                Colors.red,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Select sizes",
                                                style: appstyle(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "View size guide",
                                                style: appstyle(
                                                    20,
                                                    Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: ListView.builder(
                                                itemCount: productNotifier.shoeSizes.length,
                                                scrollDirection: Axis.horizontal,
                                                padding: EdgeInsets.zero,
                                                itemBuilder:
                                                    (context, index) {
                                                  final sizes = productNotifier.shoeSizes[index];
                                                  return Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                                                    child: ChoiceChip(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(50),
                                                          side: const BorderSide(
                                                              color: Colors.black,
                                                              width: 1,
                                                              style: BorderStyle.solid)),
                                                      disabledColor: Colors.white,
                                                      label: Text(
                                                        sizes['size'],
                                                        style: appstyle(15, sizes['isSelected'] ? Colors.white : Colors.black, FontWeight.w500),),
                                                      selectedColor: Colors.black,
                                                      padding: const EdgeInsets.symmetric(vertical:8),
                                                      selected: sizes['isSelected'],
                                                      onSelected: (newState) {
                                                        if (productNotifier.sizes.contains(sizes['size'])) {
                                                          productNotifier.sizes.remove(sizes['size']);
                                                        } else {
                                                          productNotifier.sizes.add(sizes['size']);
                                                        }
                                                        print(productNotifier.sizes);productNotifier.toggleCheck(index);
                                                      },
                                                    ),
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        indent: 10,
                                        endIndent: 10,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        child: Text(
                                          widget.sneaker.title,
                                          maxLines: 2,
                                          style: appstyle(
                                              26,
                                              Colors.black,
                                              FontWeight.w700),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        widget.sneaker.description,
                                        textAlign: TextAlign.justify,
                                        maxLines: 4,
                                        style: appstyle(14, Colors.black, FontWeight.normal),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 12),
                                          child: CheckoutButton(
                                            onTap: () async {
                                              AddToCart model = AddToCart(cartItem: widget.sneaker.id, quantity: 1);
                                              CartHelper().addToCart(model)==true? Fluttertoast.showToast(msg: "Product Not Added"):Fluttertoast.showToast(msg: "Product Added To Cart",gravity: ToastGravity.TOP);
                                            },
                                            label: "Add to Cart",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
