import 'package:flutter/material.dart';
import 'package:restaurant_app_1/page/home_screen.dart';
import 'package:restaurant_app_1/page/restaurant_screen.dart';
import 'package:restaurant_app_1/page/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Local Restaurant",
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        RestaurantScreen.routeName: (context) => const RestaurantScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
      },
    );
  }
}
