import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';

enum CurrentState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  ApiService apiService;
  SearchProvider({required this.apiService}) {}

  late RestaurantsList _restaurantsSearchList;
  RestaurantsList get restaurantSearchList => _restaurantsSearchList;

  late CurrentState _currentState;
  CurrentState get currentState => _currentState;

  String _message = "";
  String get message => _message;

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
        return _restaurantsSearchList = restaurantsList;
      }
    } catch (e) {
      _currentState = CurrentState.error;
      notifyListeners();
      return _message = "Error loading data -_-";
    }
  }
}
