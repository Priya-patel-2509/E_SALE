import 'package:e_commerce/controllers/mainscreen_provider.dart';
import 'package:e_commerce/views/components/bottom_nav.dart';
import 'package:e_commerce/views/user_interfaces/favourite_product.dart';
import 'package:e_commerce/views/user_interfaces/homepage.dart';
import 'package:e_commerce/views/user_interfaces/profile.dart';
import 'package:e_commerce/views/user_interfaces/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList =  [
    const HomePage(),
    const SearchPage(),
    const Favourite(),
    const ProfilePage()
    // const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),

          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
