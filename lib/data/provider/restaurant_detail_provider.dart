import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';

/// For each restaurant
/// When this object created, _getRestaurantDetail called
/// and the field get its data and then we use it
/// can only be used from Consumer or Provider.of
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
      print('RestoDetailState.loading.......');
      notifyListeners();
      final RestaurantDetail restaurant = await apiService.getRestaurantDetail(restaurantId);

      if (restaurant.message != "success") {
        _currentState = RestoDetailState.noData;
        notifyListeners();
        print('RestoDetailState.NoData.......');
        return _message = "No Data, Fetching Data Failed";
      } else {
        print('RestoDetailState.HasData.......');
        _currentState = RestoDetailState.hasData;
        notifyListeners();
        _restaurantDetail = restaurant;
        return _restaurantDetail;
      }
    } catch (e) {
      _currentState = RestoDetailState.error;
      print('RestoDetailState.Error.......');
      notifyListeners();
      return _message = "Error no internet connection";
    }
  }

  //  Future _getRestaurantsDetail(String restaurantId) async {
  //   try {
  //     _currentState = RestoDetailState.loading;
  //     notifyListeners();
  //     final RestaurantDetail restaurant = await apiService.getRestaurantDetail(restaurantId);

  //     if (restaurant.message != "success") {
  //       _currentState = RestoDetailState.noData;
  //       notifyListeners();
  //       return _message = "No Data, Fetching Data Failed";
  //     } else {
  //       _currentState = RestoDetailState.hasData;
  //       notifyListeners();
  //       return _restaurantDetail = restaurant;
  //     }
  //   } catch (e) {
  //     _currentState = RestoDetailState.error;
  //     notifyListeners();
  //     return _message = "Error loading data";
  //   }
  // }

}
