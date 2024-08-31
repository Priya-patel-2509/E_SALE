import 'package:e_commerce/controllers/cart_provider.dart';
import 'package:e_commerce/controllers/favorites_provider.dart';
import 'package:e_commerce/controllers/login_provider.dart';
import 'package:e_commerce/controllers/mainscreen_provider.dart';
import 'package:e_commerce/controllers/product_provider.dart';
import 'package:e_commerce/views/user_interfaces/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

// entrypoint of the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  //method that initializes the app and run top level widgets
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => ProductNotifier()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
    ChangeNotifierProvider(create: (context) => LoginProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // overall theme and app layout
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // sets the home-screen of the app
            home: SplashScreen(),
          );
        }
    );
  }
}
