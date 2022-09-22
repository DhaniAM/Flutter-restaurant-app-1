import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';

enum RestoCurrentState { init, loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  ApiService apiService;
  String resId;
  RestaurantDetailProvider({required this.apiService, required this.resId}) {
    _getRestaurantsDetail(resId);
  }

  late RestaurantDetail _restaurantDetail;
  late RestoCurrentState _currentState;
  String _message = "";
  final String medImg = "https://restaurant-api.dicoding.dev/images/medium/";

  /// Getter
  RestaurantDetail get restaurantDetail => _restaurantDetail;
  RestoCurrentState get currentState => _currentState;
  String get message => _message;

  Future _getRestaurantsDetail(String restaurantId) async {
    try {
      _currentState = RestoCurrentState.loading;
      notifyListeners();
      final RestaurantDetail restaurant =
          await apiService.getRestaurantDetail(restaurantId);

      if (restaurant.message != "success") {
        _currentState = RestoCurrentState.noData;
        notifyListeners();
        return _message = "No Data, Fetching Data Failed";
      } else {
        _currentState = RestoCurrentState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (e) {
      _currentState = RestoCurrentState.error;
      notifyListeners();
      return _message = "Error loading data";
    }
  }
}
