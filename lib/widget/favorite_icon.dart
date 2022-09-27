import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/provider/database_provider.dart';

class FavoriteIcon extends StatelessWidget {
  final Restaurant restaurant;
  const FavoriteIcon({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            bool isBookmarked = snapshot.data ?? false;
            return (isBookmarked)
                ? IconButton(
                    onPressed: () {
                      provider.removeBookmark(restaurant.id);
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      Restaurants restaurants = Restaurants(
                          id: restaurant.id,
                          city: restaurant.city,
                          description: restaurant.description,
                          name: restaurant.name,
                          pictureId: restaurant.pictureId,
                          rating: restaurant.rating);
                      provider.addBookmark(restaurants);
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                    ),
                  );
          },
        );
      },
    );
  }
}
