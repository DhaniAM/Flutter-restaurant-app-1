import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/provider/favorite_provider.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';

class GetFavoriteProvider extends ChangeNotifier {
  // get all restaurants list,
  // get all restaurants id
  // check is the Id is Favorite
  // build fav list
  GetFavoriteProvider() {
    _getRestaurantsList();
  }
  late String _message;
  late GetFavoriteState _currentState;
  late List<Restaurants> _favoriteRestaurants = <Restaurants>[];

  /// Getter
  GetFavoriteState get currentState => _currentState;
  List<Restaurants> get favoriteRestaurants => _favoriteRestaurants;
  String get message => _message;

  void _getRestaurantsList() async {
    try {
      _currentState = GetFavoriteState.loading;
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
      if (_favoriteRestaurants.isEmpty) {
        _currentState = GetFavoriteState.noData;
        _message = 'No favorite';
        notifyListeners();
      } else {
        _currentState = GetFavoriteState.hasData;
        notifyListeners();
      }
    } catch (e) {
      _currentState = GetFavoriteState.error;
      notifyListeners();
      _message = 'Error getting restaurants list';
    }
  }
}
