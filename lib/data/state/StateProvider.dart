import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';

enum CurrentState { loading, noData, hasData, error }

class StateProvider extends ChangeNotifier {
  final ApiService apiService;
  StateProvider({required this.apiService}) {
    _getRestaurantsList();
  }

  late RestaurantsList _restaurantsList;
  late RestaurantDetail _restaurantDetail;
  late CurrentState _currentState;
  String _message = "";

  RestaurantsList get restaurantsList => _restaurantsList;
  RestaurantDetail get restaurantDetail => _restaurantDetail;
  CurrentState get resultState => _currentState;
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

  Future getRestaurantsDetail(String restaurantId) async {
    try {
      _currentState = CurrentState.loading;
      notifyListeners();
      final RestaurantDetail restaurant =
          await ApiService().getRestaurantDetail(restaurantId);

      if (restaurant.message != "success") {
        _currentState = CurrentState.noData;
        notifyListeners();
        return _message = "Fetching data failed -_-";
      } else {
        _currentState = CurrentState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (e) {
      _currentState = CurrentState.error;
      notifyListeners();
      return _message = "Error loading data -_-";
    }
  }

  Future getSearchResult(String searchText) async {
    try {
      _currentState = CurrentState.loading;
      notifyListeners();
      RestaurantsList restaurantsList =
          await ApiService().getSearchResults(searchText);
      if (restaurantsList.restaurants.isEmpty) {
        _currentState = CurrentState.noData;
        notifyListeners();
        return _message = "No data -_-";
      } else {
        _currentState = CurrentState.hasData;
        notifyListeners();
        return _restaurantsList = restaurantsList;
      }
    } catch (e) {
      _currentState = CurrentState.error;
      notifyListeners();
      return _message = "Error loading data -_-";
    }
  }

  /// for [SearchScreen]
  bool _searchState = false;
  bool _hasData = false;

  bool get searchState => _searchState;
  bool get hasData => _hasData;

  set setSearchState(bool value) {
    _searchState = value;
  }

  set sethasData(bool value) {
    _hasData = value;
  }
}
