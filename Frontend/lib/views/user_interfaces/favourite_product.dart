import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controllers/favorites_provider.dart';
import 'package:e_commerce/views/components/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> with TickerProviderStateMixin{
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 3))..repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context,listen: true);
    favoritesNotifier.getAllData();
    return Scaffold(
      body:SizedBox(
        height: MediaQuery.of(context).size.height*1,
        width: MediaQuery.of(context).size.width*1,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width*1,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_image.png"),
                      fit: BoxFit.fill)),
              child: Padding(padding: const EdgeInsets.all(8.0),
              child:Text("My Favorites",style: appstyle(36, Colors.white,FontWeight.bold),)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: favoritesNotifier.fav.isEmpty
                  ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "assets/json/empty_fav.json",
                        controller: _controller,
                        height: MediaQuery.of(context).size.height*0.3,
                      ),
                      const SizedBox(height: 10,),
                      Text("You Have Not Any Favorites",style: appstyle(15, Colors.black, FontWeight.bold),),
                      const SizedBox(height: 10,),
                      Text("Go ahead choose your favorites",style: appstyle(15, Colors.black, FontWeight.normal),)
                    ],
                  )
              )
                  :ListView.builder(
                  itemCount: favoritesNotifier.fav.length,
                  padding: const EdgeInsets.only(top: 100),
                  itemBuilder: (BuildContext context,int index){
                  final shoe= favoritesNotifier.fav[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.11,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              spreadRadius: 5,
                              blurRadius: 0.3,
                              offset: const Offset(0,1)
                            ),]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: CachedNetworkImage(imageUrl:  shoe?["imageUrl"] ?? " ",
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0,left: 20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(shoe['name']?? "",style: appstyle(15, Colors.black, FontWeight.bold),),
                                      const SizedBox(height: 5,),
                                      Text(shoe['category']?? "",style: appstyle(14, Colors.grey,FontWeight.w600),),
                                      const SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text("₹${shoe['price']}"?? "",style: appstyle(18, Colors.black,FontWeight.w600),)
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () async{
                                await favoritesNotifier.deleteFav(shoe['key']);
                                favoritesNotifier.ids.removeWhere((element)=>element==shoe['id']);
                              },
                              child: const Icon(Ionicons.heart_dislike_circle),
                            ),)
                          ],
                        ),
                      ),
                    ),
                  );
              }),
            )
          ],
        ),
      )
    );
  }
}
