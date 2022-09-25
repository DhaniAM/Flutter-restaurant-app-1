import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';

/// For each restaurant
/// When this object created, _getRestaurantDetail called
/// and the field get its data and then we use it
class RestaurantDetailProvider extends ChangeNotifier {
  ApiService apiService;
  String resId;
  RestaurantDetailProvider({required this.apiService, required this.resId}) {
    _getRestaurantsDetail(resId);
  }

  late RestaurantDetail _restaurantDetail;
  late RestoDetailState _currentState;
  String _message = "";
  final String medImg = "https://restaurant-api.dicoding.dev/images/medium/";

  /// Getter
  RestaurantDetail get restaurantDetail => _restaurantDetail;
  RestoDetailState get currentState => _currentState;
  String get message => _message;

  Future _getRestaurantsDetail(String restaurantId) async {
    try {
      _currentState = RestoDetailState.loading;
      notifyListeners();
      final RestaurantDetail restaurant = await apiService.getRestaurantDetail(restaurantId);

      if (restaurant.message != "success") {
        _currentState = RestoDetailState.noData;
        notifyListeners();
        return _message = "No Data, Fetching Data Failed";
      } else {
        _currentState = RestoDetailState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (e) {
      _currentState = RestoDetailState.error;
      notifyListeners();
      return _message = "Error loading data";
    }
  }
}
