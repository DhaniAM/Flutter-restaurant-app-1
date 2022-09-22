import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';

class RestaurantListResult extends StatelessWidget {
  final RestaurantsList restaurantsList;
  const RestaurantListResult({super.key, required this.restaurantsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurantsList.restaurants.length,
      itemBuilder: (context, index) {
        return RestaurantCard(restaurants: restaurantsList.restaurants[index]);
      },
    );
  }
}
