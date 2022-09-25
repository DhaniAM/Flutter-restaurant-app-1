import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/provider/get_favorite_provider.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';
import 'package:restaurant_app_1/widget/favorite_list_builder.dart';
import 'package:restaurant_app_1/widget/state_message.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GetFavoriteProvider>(
      builder: (context, data, child) {
        /// Loading state
        if (data.currentState == GetFavoriteState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Color.fromRGBO(255, 106, 106, 1)),
          );

          /// No Data state
        } else if (data.currentState == GetFavoriteState.noData) {
          return StateMessage(icon: Icons.heart_broken, text: data.message);

          /// Error state
        } else if (data.currentState == GetFavoriteState.error) {
          return StateMessage(icon: Icons.cancel_rounded, text: data.message);

          /// hasData state
        } else if (data.currentState == GetFavoriteState.hasData) {
          return FavoriteListBuilder(restaurantsList: data.favoriteRestaurants);

          /// no internet state
        } else {
          return StateMessage(icon: Icons.cancel, text: data.message);
        }
      },
    );
  }
}
