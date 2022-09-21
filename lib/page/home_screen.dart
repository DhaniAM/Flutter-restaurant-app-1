import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/widget/restaurant_card.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';

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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.search_rounded,
              ),
            ),
          ),
        ],
      ),

      /// Each Restaurant List
      body: FutureBuilder(
        future: restaurantsList,
        builder: (context, data) {
          /// Show error screen if data is error
          if (data.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.warning_rounded, size: 50),
                  Text("Error loading data from internet."),
                  Text("Please check your internet connection."),
                  Text("-_-"),
                ],
              ),
            );
          } else if (data.hasData) {
            /// Change the Future type to Object type
            RestaurantsList restaurantsList = data.data as RestaurantsList;
            return ListView.builder(
              itemBuilder: ((context, index) {
                /// Pass the [RestaurantList] object to [RestaurantCard]
                return RestaurantCard(
                    restaurantsList: restaurantsList, index: index);
              }),
              itemCount: restaurantsList.count,
            );
          } else {
            /// Loading Screen
            return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 106, 106, 1)),
            );
          }
        },
      ),
    );
  }
}
