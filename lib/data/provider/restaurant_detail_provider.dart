import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';

/// ALl Provider can only be accessed from Consumer or Provider.of inside ChangeNotifierProvider
class RestaurantDetailProvider extends ChangeNotifier {
  ApiService apiService;
  RestaurantDetailProvider({required this.apiService});

  late RestaurantDetail _restaurantDetail;
  RestoDetailState _currentState = RestoDetailState.hasData;
  String _message = "";

  /// Getter
  RestaurantDetail get restaurantDetail => _restaurantDetail;
  RestoDetailState get currentState => _currentState;
  String get message => _message;

  Future getRestaurantsDetail(String restaurantId) async {
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
        _restaurantDetail = restaurant;
        return _restaurantDetail;
      }
    } catch (e) {
      _currentState = RestoDetailState.error;
      notifyListeners();
      return _message = "Error no internet connection";
    }
  }
}
