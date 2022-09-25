import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/provider/favorite_provider.dart';

class GetFavoriteProvier extends ChangeNotifier {
  // get all restaurants list,
  // get all restaurants id
  // check is the Id is Favorite
  // build fav list
  GetFavoriteProvier() {
    _getRestaurantsList();
  }
  late String _message;
  late List<Restaurants> _favoriteRestaurants = <Restaurants>[];

  /// Getter
  List<Restaurants> get favoriteRestaurants => _favoriteRestaurants;

  void _getRestaurantsList() async {
    try {
      final restaurantsList = await ApiService().getRestaurantsList();
      final int resLen = restaurantsList.restaurants.length;
      for (int i = 0; i < resLen; i++) {
        final restaurants = restaurantsList.restaurants[i];
        final String resId = restaurants.id;
        final bool isFav = await FavoriteProvider().isFavPref(resId);
        if (isFav) {
          _favoriteRestaurants.add(restaurants);
        }
      }
    } catch (e) {
      _message = 'Error getting restaurants list';
    }
  }
}
