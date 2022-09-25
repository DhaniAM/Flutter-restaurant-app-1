import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/provider/favorite_list_provider.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';
import 'package:restaurant_app_1/widget/favorite_list_builder.dart';
import 'package:restaurant_app_1/widget/state_message.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteListProvider>(
      builder: (context, data, child) {
        /// Loading state
        if (data.currentState == FavoriteListState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Color.fromRGBO(255, 106, 106, 1)),
          );

          /// hasData state
        } else if (data.currentState == FavoriteListState.hasData) {
          return FavoriteListBuilder(restaurantsList: data.favoriteRestaurants);

          /// No Data state
        } else if (data.currentState == FavoriteListState.noData) {
          return StateMessage(icon: Icons.heart_broken, text: data.message);

          /// Error state
        } else {
          return StateMessage(icon: Icons.cancel_rounded, text: data.message);
        }
      },
    );
  }
}
