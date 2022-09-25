import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';

class FavoriteListBuilder extends StatelessWidget {
  final List<Restaurants> restaurantsList;
  const FavoriteListBuilder({super.key, required this.restaurantsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurantsList.length,
      itemBuilder: (context, index) {
        return RestaurantCard(restaurants: restaurantsList[index]);
      },
    );
  }
}
