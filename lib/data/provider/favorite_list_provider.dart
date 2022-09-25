import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/provider/favorite_provider.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';

/// for Favorite Screen
class FavoriteListProvider extends ChangeNotifier {
  // get all restaurants list,
  // get all restaurants id
  // check is the Id is Favorite
  // build fav list
  FavoriteListProvider() {
    _setRestaurantsList();
  }
  late String _message;
  late FavoriteListState _currentState;
  final List<Restaurants> _favoriteRestaurants = <Restaurants>[];

  /// Getter
  FavoriteListState get currentState => _currentState;
  List<Restaurants> get favoriteRestaurants => _favoriteRestaurants;
  String get message => _message;

  set setCurrentState(FavoriteListState state) => _currentState = state;

  void _setRestaurantsList() async {
    try {
      _currentState = FavoriteListState.loading;
      notifyListeners();
      final restaurantsList = await ApiService().getRestaurantsList();
      final int resLen = restaurantsList.restaurants.length;

      for (int i = 0; i < resLen; i++) {
        final restaurants = restaurantsList.restaurants[i];
        final String resId = restaurants.id;
        final data = await FavoriteProvider(resId: resId);
        final bool isFav = data.isFav;
        if (isFav) {
          _favoriteRestaurants.add(restaurants);
        }
      }

      if (_favoriteRestaurants.isEmpty) {
        _currentState = FavoriteListState.noData;
        _message = 'No favorite';
        notifyListeners();
      } else if (_favoriteRestaurants.isNotEmpty) {
        _currentState = FavoriteListState.hasData;
        _message = 'has Data';
        notifyListeners();
      }
    } catch (e) {
      _currentState = FavoriteListState.error;
      notifyListeners();
      _message = 'Error getting restaurants list';
    }
  }
}
