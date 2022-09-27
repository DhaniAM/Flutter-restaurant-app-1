import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';

/// ALl Provider can only be accessed from Consumer or Provider.of inside ChangeNotifierProvider
class SearchProvider extends ChangeNotifier {
  ApiService apiService;
  SearchProvider({required this.apiService});

  late RestaurantsList _restaurantsList;
  SearchCurrentState _searchCurrentState = SearchCurrentState.init;
  String _message = "";

  /// For Text Input
  final TextEditingController _controller = TextEditingController();

  /// for Search button state
  bool _searchState = false; // is user still focus on search bar

  /// Getter
  RestaurantsList get restaurantsList => _restaurantsList;
  TextEditingController get controller => _controller;
  SearchCurrentState get currentState => _searchCurrentState;
  String get message => _message;

  /// for Search icon
  bool get searchState => _searchState;

  /// Setter
  setSearchState(bool value) {
    _searchState = value;
    notifyListeners();
  }

  Future getSearchResult(String searchText) async {
    try {
      _searchCurrentState = SearchCurrentState.loading;
      notifyListeners();
      RestaurantsList restaurantsList = await apiService.getSearchResults(searchText);
      if (restaurantsList.restaurants.isEmpty) {
        _searchCurrentState = SearchCurrentState.noData;
        notifyListeners();
        return _message = "No data";
      } else {
        _searchCurrentState = SearchCurrentState.hasData;
        notifyListeners();
        return _restaurantsList = restaurantsList;
      }
    } catch (e) {
      _searchCurrentState = SearchCurrentState.error;
      notifyListeners();
      return _message = "Error loading data \n Check your internet connection";
    }
  }
}
