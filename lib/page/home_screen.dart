import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/page/search_screen.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/widget/restaurants_list_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RestaurantsList> restaurantsList;
  late Future<RestaurantDetail> restaurantDetail;

  /// This function called everytime the state change / widget is build
  @override
  void initState() {
    super.initState();
    restaurantsList = ApiService().getRestaurantsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// App Bar
        appBar: AppBar(
          title: const Text("Local Restaurants"),
          backgroundColor: const Color.fromRGBO(255, 106, 106, 1),

          /// Search Icon
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
                child: const Icon(
                  Icons.search_rounded,
                ),
              ),
            ),
          ],
        ),

        /// Each Restaurant List
        body: RestaurantListResult(
          restaurantsList: restaurantsList,
        ));
  }
}
