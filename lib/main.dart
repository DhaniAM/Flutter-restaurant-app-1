import 'package:flutter/material.dart';
import 'package:restaurant_app_1/page/main_screen.dart';
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
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(255, 106, 106, 1),
        splashColor: Color.fromRGBO(67, 218, 239, 1),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MainScreen(),
        RestaurantScreen.routeName: (context) => const RestaurantScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
      },
    );
  }
}
