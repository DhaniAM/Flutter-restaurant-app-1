import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/state/StateProvider.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';
import 'package:provider/provider.dart';


class RestaurantListResult extends StatelessWidget {
  const RestaurantListResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, StateProvider value, child) {
        return ListView.builder(
          itemCount: value.getRestaurantsList(),
          itemBuilder: (context, index) {
            if(value.getRestaurantsList())
          },

          )
        
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
      //   } else {
      //     /// Loading Screen
      //     return const Center(
      //       child: CircularProgressIndicator(
      //           color: Color.fromRGBO(255, 106, 106, 1)),
      //     );
      //   }