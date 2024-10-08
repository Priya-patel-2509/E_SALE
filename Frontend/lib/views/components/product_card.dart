import 'package:e_commerce/controllers/favorites_provider.dart';
import 'package:e_commerce/models/constants.dart';
import 'package:e_commerce/views/components/appstyle.dart';
import 'package:e_commerce/views/user_interfaces/favourite_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

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


  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context,listen: true);
    favoritesNotifier.getFavorites();
    bool selected = true;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: NetworkImage(widget.image),fit: BoxFit.cover)),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () async{
                        if(favoritesNotifier.ids.contains(widget.id)){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Favourite()));
                        }else{
                          _createFav({
                            "id":widget.id,
                            "name":widget.name,
                            "category":widget.category,
                            "price":widget.price,
                            "imageUrl":widget.image
                          });
                        }
                      },
                      child: favoritesNotifier.ids.contains(widget.id) ? const Icon (AntDesign.heart,color: Colors.red,): const Icon(AntDesign.hearto),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20,left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name,
                      style: appstyleWithHt(
                          26, Colors.black, FontWeight.bold, 1.1),
                    ),
                    Text(
                      widget.category,
                      style:
                          appstyleWithHt(18, Colors.grey, FontWeight.bold, 1.5),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: appstyle(20, Colors.black, FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
