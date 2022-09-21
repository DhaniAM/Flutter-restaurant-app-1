import 'package:flutter/material.dart';
import 'package:restaurant_app_1/page/home_screen.dart';
import 'package:restaurant_app_1/page/restaurant_screen.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Local Restaurant",
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/restaurantScreen": (context) => const RestaurantScreen(),
      },
    );
  }
}
