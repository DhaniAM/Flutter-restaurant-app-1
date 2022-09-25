import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/provider/favorite_provider.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';

class FavoriteIcon extends StatelessWidget {
  final String resId;
  const FavoriteIcon({super.key, required this.resId});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, data, child) {
        /// if Loading
        if (data.isFav == false) {
          return IconButton(
            onPressed: () {
              data.toggleFavPref();
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.grey,
            ),
          );
        } else {
          return IconButton(
            onPressed: () {
              data.toggleFavPref();
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
          );
        }
      },
    );
  }
}
