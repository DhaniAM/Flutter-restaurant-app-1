import 'package:flutter/material.dart';
import 'package:restaurant_app_1/restaurant_card.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return RestaurantCard();
        },
        itemCount: 10,
      ),
    );
  }
}
