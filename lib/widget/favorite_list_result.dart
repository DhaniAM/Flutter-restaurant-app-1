import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/provider/favorite_provider.dart';
import 'package:restaurant_app_1/data/provider/home_provider.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';
import 'package:restaurant_app_1/widget/restaurants_list_result.dart';

class FavoriteListResult extends StatelessWidget {
  const FavoriteListResult({super.key});

  @override
  Widget build(BuildContext context) {
    // return Text('data');
    return Consumer2<HomeProvider, FavoriteProvider>(
      builder: (context, homeData, favData, child) {
        List<Restaurants> listRestaurants = <Restaurants>[];
        for (int i = 0; i < homeData.restaurantsList.restaurants.length; i++) {
          final restaurant = homeData.restaurantsList.restaurants[i];
          favData
              .isFavPref(restaurant.id)
              .then((value) => {listRestaurants.add(restaurant)});
        }
        RestaurantsList restaurantsList =
            RestaurantsList(error: false, restaurants: listRestaurants);
        return RestaurantListResult(restaurantsList: restaurantsList);
        // return ListView.builder(
        //   itemBuilder: (context, index) {
        //     /// get each restaurants from HomeProvider
        //
        // favData.isFavPref(restaurants.id).then((value) => {
        //           isFav = value,
        //           resto.add(restaurants),
        //         });

        //     /// check is current restaurants is favorite
        //     bool? isFav;
        //     favData.isFavPref(restaurants.id).then((value) => {
        //           isFav = value,
        //           resto.add(restaurants),
        //         });
        //     if (isFav == false) {
        //       return RestaurantCard(restaurants: restaurants);
        //     } else {
        //       return SizedBox();
        //     }
        //   },
        //   itemCount: resto.length,
        // );
      },
    );
  }
}
