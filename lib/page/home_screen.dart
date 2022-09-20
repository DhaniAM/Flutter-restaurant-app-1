import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';
import 'package:restaurant_app_1/data/model/restaurants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Parse JSON to Object
  Future<Restaurants> getRestaurants() async {
    /// Get data from JSON file
    final jsonData = await rootBundle.loadString("asset/local_restaurant.json");

    /// Parse JSON to Restaurants
    Restaurants restaurants = Restaurants.fromJson(jsonDecode(jsonData));
    return restaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Restaurants"),
        backgroundColor: const Color.fromRGBO(255, 106, 106, 1),
      ),
      body: FutureBuilder(
        future: getRestaurants(),
        builder: (context, data) {
          /// Error message
          if (data.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (data.hasData) {
            Restaurants restaurants = data.data as Restaurants;
            return ListView.builder(
              itemBuilder: ((context, index) {
                return RestaurantCard(
                    restaurantName: restaurants.restaurants[index].name,
                    restaurantCity: restaurants.restaurants[index].city,
                    restaurantId: restaurants.restaurants[index].id,
                    restaurantDescription:
                        restaurants.restaurants[index].description,
                    restaurantPictureId:
                        restaurants.restaurants[index].pictureId,
                    restaurantRating: restaurants.restaurants[index].rating,
                    restaurantFoods: restaurants.restaurants[index].menus.foods,
                    restaurantDrinks:
                        restaurants.restaurants[index].menus.drinks);
              }),
              itemCount: restaurants.restaurants.length,
            );
          } else {
            /// Loading Screen
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
