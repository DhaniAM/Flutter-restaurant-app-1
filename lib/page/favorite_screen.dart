import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/provider/favorite_provider.dart';
import 'package:restaurant_app_1/data/provider/home_provider.dart';
import 'package:restaurant_app_1/widget/favorite_list_builder.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';
import 'package:restaurant_app_1/widget/restaurants_list_builder.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List<Restaurants> listRestaurants = <Restaurants>[];
    return Text('data');
    // return Consumer2<HomeProvider, FavoriteProvider>(
    //   builder: (context, homeData, favData, child) {
    //     for (int i = 0; i < homeData.restaurantsList.restaurants.length; i++) {
    //       final restaurant = homeData.restaurantsList.restaurants[i];
    //       return FutureBuilder(
    //         future: favData.isFavPref(restaurant.id),
    //         builder: (context, snapshot) {
    //           bool data = snapshot.data as bool;
    //           if (data) {
    //             listRestaurants.add(restaurant);
    //           } else {}
    //         },
    //       );
    //       favData.isFavPref(restaurant.id).then((value) => {listRestaurants.add(restaurant)});
    //     }
    //     ;
    //     if (listRestaurants.isNotEmpty) {
    //       return FavoriteListBuilder(restaurantsList: listRestaurants);
    //     } else {
    //       return Center(
    //         child: Text('No fav'),
    //       );
    //     }
    // RestaurantsList restaurantsList =
    //     RestaurantsList(error: false, restaurants: listRestaurants);

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
    //   },
    // );
  }
}
