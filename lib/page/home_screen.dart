import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/state/StateProvider.dart';
import 'package:restaurant_app_1/page/search_screen.dart';
import 'package:restaurant_app_1/widget/restaurants_list_result.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateProvider(),
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
          body: Consumer<StateProvider>(
            builder: (context, StateProvider data, child) {
              return RestaurantListResult(
                restaurantsList: data.restaurantsList,
              );
            },
          )),
    );
  }
}
