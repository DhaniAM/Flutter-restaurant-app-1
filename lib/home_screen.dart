import 'package:flutter/material.dart';
import 'package:restaurant_app_1/restaurant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return RestaurantCard(
            restaurantId: "id",
            restaurantName: "nama",
            restaurantCity: "city",
            restaurantDescription: "desc",
            restaurantPictureId: "picId",
            restaurantRating: 4.2,
            restaurantFoods: ["food1", "food2"],
            restaurantDrinks: ["drink1", "drink2"],
          );
        },
        itemCount: 10,
      ),
    );
  }
}
