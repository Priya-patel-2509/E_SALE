import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/views/components/appstyle.dart';
import 'package:flutter/material.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile({super.key, required this.imageUrl, required this.name, required this.price});
  final String imageUrl;
  final String name;
  final String price;
  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              height: 150,
              fit: BoxFit.cover,
            ),
            Container(
              padding:const EdgeInsets.only(top: 0),
              height: 75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                  style: appstyleWithHt(18, Colors.black, FontWeight.w700, 1),),
                  Text(widget.price,
                  style: appstyleWithHt(15, Colors.black, FontWeight.w500, 1),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
