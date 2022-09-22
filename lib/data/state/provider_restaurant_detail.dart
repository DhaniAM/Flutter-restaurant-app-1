import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';

enum CurrentState { loading, noData, hasData, error }

class ProviderRestaurantDetail extends ChangeNotifier {
  ApiService apiService;
  ProviderRestaurantDetail({required this.apiService}) {}

  late RestaurantDetail _restaurantDetail;
  RestaurantDetail get restaurantDetail => _restaurantDetail;

  late CurrentState _currentState;
  CurrentState get currentState => _currentState;

  String _message = "";
  String get message => _message;

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
}
