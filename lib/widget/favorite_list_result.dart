import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/provider/favorite_provier.dart';
import 'package:restaurant_app_1/data/provider/home_provider.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';

class FavoriteListResult extends StatelessWidget {
  const FavoriteListResult({super.key});

  @override
  Widget build(BuildContext context) {
    int _itemCount = 0;
    // return Text('data');
    return Consumer2<HomeProvider, FavoriteProvider>(
      builder: (context, homeData, favData, child) {
        return ListView.builder(
          itemCount: _itemCount,
          itemBuilder: (context, index) {
            /// get each restaurants from HomeProvider
            Restaurants restaurants =
                homeData.restaurantsList.restaurants[index];

            /// get each restaurant isFav from FavoriteProvider
            bool resFavId = false;
            favData.isFavPref(restaurants.id).then((value) => resFavId = value);

            /// check if the current restaurant is favorite
            if (resFavId == true) {
              _itemCount++;
              return RestaurantCard(restaurants: restaurants);
            } else {
              return const Center(
                child: Text("No Favorite Restaurant"),
              );
            }
          },
        );
      },
    );
  }
}
