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

  /// This function called everytime the widget is build
  @override
  void initState() {
    super.initState();
    restaurantsList = ApiService().getRestaurantsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Restaurants"),
        backgroundColor: const Color.fromRGBO(255, 106, 106, 1),
      ),
      body: FutureBuilder(
        future: restaurantsList,
        builder: (context, data) {
          /// Error message
          if (data.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (data.hasData) {
            RestaurantsList restaurantsList = data.data as RestaurantsList;
            return ListView.builder(
              itemBuilder: ((context, index) {
                /// get each [RestaurantDetail] to pass to [RestaurantCard]
                restaurantDetail = ApiService()
                    .getRestaurantDetail(restaurantsList.restaurants[index].id);
                RestaurantDetail resDetail =
                    restaurantDetail as RestaurantDetail;
                return RestaurantCard(restaurantDetail: resDetail);
              }),
              itemCount: restaurantsList.count,
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
