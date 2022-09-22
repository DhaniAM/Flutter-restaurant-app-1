import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/state/home_provider.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';

class RestaurantListResult extends StatelessWidget {
  final RestaurantsList restaurantsList;
  const RestaurantListResult({super.key, required this.restaurantsList});

  @override
  Widget build(BuildContext context) {
    final restaurantsList = Provider.of<StateProvider>(context).restaurantsList;
    StateProvider provider = Provider.of<StateProvider>(context);

    return ListView.builder(
      itemCount: restaurantsList.restaurants.length,
      itemBuilder: (context, index) {
        if (CurrentState.error == true) {}
        return RestaurantCard(index: index);
      },
    );
  }
}


         /// Show error screen if data is error
      //    if(data.hasError)
      //     return Center(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: const <Widget>[
      //           Icon(Icons.warning_rounded, size: 50),
      //           Text("Error loading data from internet."),
      //           Text("Please check your internet connection."),
      //           Text("-_-"),
      //         ],
      //       ),
      //     );
      //   } else if (data.hasData) {
      //     /// Change the Future type to Object type
      //     RestaurantsList restaurantsList = data.data as RestaurantsList;
      //     int resLen = restaurantsList.restaurants.length;
      //     return ListView.builder(
      //       itemBuilder: ((context, index) {
      //         /// Pass the [RestaurantList] object to [RestaurantCard]
      //         return RestaurantCard(
      //             restaurantsList: restaurantsList, index: index);
      //       }),
      //       itemCount: resLen,
      //     );
      //   }