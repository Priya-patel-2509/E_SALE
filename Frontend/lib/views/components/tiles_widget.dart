import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';


class TilesWidget extends StatelessWidget {
  final String title;
  final IconData leading;
  final Function()? OnTap;

  const TilesWidget({
    super.key,
    required this.title,
    required this.leading,
    required this.OnTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: OnTap,
        leading: Icon(leading),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: title != "Settings"
            ? const Icon(
                AntDesign.right,
                size: 16,
              )
            : SvgPicture.asset(
                "assets/images/usa.svg",
                width: 15,
                height: 20,
              ));
  }
}