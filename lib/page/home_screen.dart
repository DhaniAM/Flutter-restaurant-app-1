import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/provider/home_provider.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';
import 'package:restaurant_app_1/widget/restaurants_list_builder.dart';
import 'package:restaurant_app_1/widget/state_message.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, HomeProvider data, child) {
        /// Loading state
        if (data.currentState == HomeCurrentState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Color.fromRGBO(255, 106, 106, 1)),
          );

          /// No Data state
        } else if (data.currentState == HomeCurrentState.noData) {
          return StateMessage(icon: Icons.fastfood, text: data.message);

          /// Error state
        } else if (data.currentState == HomeCurrentState.error) {
          return StateMessage(icon: Icons.cancel_rounded, text: data.message);

          /// hasData state
        } else if (data.currentState == HomeCurrentState.hasData) {
          return RestaurantsListBuilder(restaurantsList: data.restaurantsList);

          /// state when the Screen start
        } else {
          return StateMessage(icon: Icons.fastfood, text: data.message);
        }
      },
    );
  }
}
