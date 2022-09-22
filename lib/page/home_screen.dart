import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/provider/home_provider.dart';
import 'package:restaurant_app_1/page/search_screen.dart';
import 'package:restaurant_app_1/widget/restaurants_list_result.dart';
import 'package:restaurant_app_1/widget/state_message.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(apiService: ApiService()),
      child: Scaffold(
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
        body: Consumer<HomeProvider>(
          builder: (context, HomeProvider data, child) {
            if (data.currentState == HomeCurrentState.loading) {
              return const Center(
                child: CircularProgressIndicator(
                    color: Color.fromRGBO(255, 106, 106, 1)),
              );
            } else if (data.currentState == HomeCurrentState.noData) {
              return StateMessage(icon: Icons.fastfood, text: data.message);
            } else if (data.currentState == HomeCurrentState.error) {
              return StateMessage(
                  icon: Icons.cancel_rounded, text: data.message);
            } else if (data.currentState == HomeCurrentState.hasData) {
              return RestaurantListResult(
                  restaurantsList: data.restaurantsList);
            } else {
              return StateMessage(icon: Icons.fastfood, text: data.message);
            }
          },
        ),
      ),
    );
  }
}
