import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';

/// ALl Provider can only be accessed from Consumer or Provider.of inside ChangeNotifierProvider
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

      /// Tell all widget _currentState value has changed, so widgets will
      /// change based on this _currentState value
      notifyListeners();

      /// get the API data
      final RestaurantsList restaurantsList = await apiService.getRestaurantsList();

      /// if there is NO DATA or if the API can't get the Data
      if (restaurantsList.restaurants.isEmpty) {
        /// Tell all widget that there's no data
        _currentState = HomeCurrentState.noData;
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
      /// if no internet
      _currentState = HomeCurrentState.error;
      notifyListeners();
      return _message = "Error no internet connection";
    }
  }
}
