import 'package:flutter/material.dart';
import 'package:restaurant_app_1/restaurants.dart';

class RestaurantScreen extends StatelessWidget {
  final String restaurantId;
  final String restaurantName;
  final String restaurantCity;
  final String restaurantDescription;
  final String restaurantPictureId;
  final double restaurantRating;
  final List<Food> restaurantFoods;
  final List<Drink> restaurantDrinks;

  const RestaurantScreen(
      {Key? key,
      required this.restaurantName,
      required this.restaurantCity,
      required this.restaurantId,
      required this.restaurantDescription,
      required this.restaurantPictureId,
      required this.restaurantRating,
      required this.restaurantFoods,
      required this.restaurantDrinks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            /// Top Image
            // Image.asset(
            //   restaurantPictureId,
            // ),
            Text(restaurantPictureId),

            /// Restaurant Name
            Text(restaurantName),

            /// Location
            Text(restaurantCity),

            /// Description
            Text(restaurantDescription),

            /// Menu
            const Text("Menu"),

            /// Foods
            const Text("Food"),
            for (int i = 0; i < restaurantFoods.length; i++)
              Text(restaurantFoods[i].name),

            /// Drinks
            const Text("Drink"),
            for (int i = 0; i < restaurantDrinks.length; i++)
              Text(restaurantDrinks[i].name),
          ],
        ),
      ),
    );
  }
}
