import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/provider/database_provider.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';
import 'package:restaurant_app_1/widget/favorite_list_builder.dart';
import 'package:restaurant_app_1/widget/state_message.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, data, child) {
        /// Loading state
        if (data.currentState == DatabaseState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Color.fromRGBO(255, 106, 106, 1)),
          );

          /// No Data state
        } else if (data.currentState == DatabaseState.noData) {
          return StateMessage(icon: Icons.heart_broken, text: data.message);

          /// Error state
        } else if (data.currentState == DatabaseState.error) {
          return StateMessage(icon: Icons.cancel, text: data.message);

          /// has Data state
        } else if (data.currentState == DatabaseState.hasData) {
          return FavoriteListBuilder(restaurantsList: data.bookmarks);

          /// other state
        } else {
          return StateMessage(icon: Icons.fastfood, text: data.message);
        }
      },
    );
  }
}
