import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';

class StateProvider extends ChangeNotifier {
  /// Call the API to get data
  /// for [HomeScreen]
  Future<RestaurantsList> _restaurantsList = ApiService().getRestaurantsList();

  Future<RestaurantsList> get restaurantsList {
    return _restaurantsList;
  }

  /// for [SearchScreen]
  bool _searchState = false;
  bool _hasData = false;

  bool get searchState {
    return _searchState;
  }

  set setSearchState(bool value) {
    _searchState = value;
  }

  bool get hasData {
    return _hasData;
  }

  set sethasData(bool value) {
    _hasData = value;
  }

  void complete(
      Future<RestaurantsList> restaurantsList, bool searchState, bool hasData) {
    _restaurantsList = restaurantsList;
    _searchState = searchState;
    _hasData = hasData;

    /// notify that state has Changed
    notifyListeners();
  }
}
