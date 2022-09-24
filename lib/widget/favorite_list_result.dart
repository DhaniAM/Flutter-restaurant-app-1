import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/provider/favorite_provier.dart';
import 'package:restaurant_app_1/data/provider/home_provider.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';

class FavoriteListResult extends StatelessWidget {
  const FavoriteListResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, FavoriteProvider>(
      builder:
          (context, HomeProvider homeData, FavoriteProvider favData, child) {
        if (favData.favPrefs == true) {
          return ListView.builder(itemCount: 2 ,itemBuilder: (context, index) {
            return RestaurantCard(restaurants: Restaurants)
          },));
        }
      },
    );
  }
}
