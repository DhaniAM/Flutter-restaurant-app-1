import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';

enum CurrentState { loading, noData, hasData, error }

class StateProvider extends ChangeNotifier {
  /// to Fetch data from API from the start when StateProvider is created in
  /// [main.dart]
  final ApiService apiService;
  StateProvider({required this.apiService}) {
    _getRestaurantsList();
  }

  late RestaurantsList _restaurantsList;
  RestaurantsList get restaurantsList => _restaurantsList;

  late CurrentState _currentState;
  CurrentState get currentState => _currentState;

  String _message = "";
  String get message => _message;

  Future _getRestaurantsList() async {
    try {
      /// tell that current state is Loading
      _currentState = CurrentState.loading;

      /// Tell all widget that it's still loading, so that the widget
      /// will show Loading indicator
      notifyListeners();

      /// get the API data
      final RestaurantsList restaurantsList =
          await ApiService().getRestaurantsList();

      /// if there is NO DATA or if the API can't get the Data
      if (restaurantsList.restaurants.isEmpty) {
        _currentState = CurrentState.noData;

        /// Tell all widget that there's no data
        notifyListeners();

        return _message = "No Data -_-";
      } else {
        /// else if there is data
        /// set the current state to tell that we have data
        _currentState = CurrentState.hasData;
        notifyListeners();
        return _restaurantsList = restaurantsList;
      }
    } catch (e) {
      _currentState = CurrentState.error;
      notifyListeners();
      return _message = "Error --> $e";
    }
  }

  /// for [SearchScreen]
  TextEditingController _controller = TextEditingController();
  bool _searchState = false;
  bool _hasData = false;

  TextEditingController get controller => _controller;
  bool get searchState => _searchState;
  bool get hasData => _hasData;

  setSearchState(bool value) {
    _searchState = value;
    notifyListeners();
  }

  setHasData(bool value) {
    _hasData = value;
    notifyListeners();
  }
}
