import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService apiService;
  HomeProvider({required this.apiService}) {
    _getRestaurantsList();
  }

  late RestaurantsList _restaurantsList;
  late HomeCurrentState _currentState;
  String _message = "";

  /// Getter
  RestaurantsList get restaurantsList => _restaurantsList;
  HomeCurrentState get currentState => _currentState;
  String get message => _message;

  /// Setter
  setCurrentState(HomeCurrentState state) => _currentState = state;

  Future _getRestaurantsList() async {
    try {
      /// tell that current state is Loading
      _currentState = HomeCurrentState.loading;

      /// Tell all widget that it's still loading, so that the widget
      /// will show Loading indicator
      notifyListeners();

      /// get the API data
      final RestaurantsList restaurantsList = await apiService.getRestaurantsList();

      /// if there is NO DATA or if the API can't get the Data
      if (restaurantsList.restaurants.isEmpty) {
        _currentState = HomeCurrentState.noData;

        /// Tell all widget that there's no data
        notifyListeners();

        return _message = "No Data";
      } else {
        /// else if there is data
        /// set the current state to tell that we have data
        _currentState = HomeCurrentState.hasData;
        notifyListeners();
        return _restaurantsList = restaurantsList;
      }
    } catch (e) {
      _currentState = HomeCurrentState.error;
      notifyListeners();
      return _message = "Error no internet connection";
    }
  }
}
