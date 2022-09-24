import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RestoCurrentState { init, loading, noData, hasData, error }

/// For each restaurant
class RestaurantDetailProvider extends ChangeNotifier {
  ApiService apiService;
  String resId;
  RestaurantDetailProvider({required this.apiService, required this.resId}) {
    _getRestaurantsDetail(resId);
    setFavPref(resId);
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

  /// We can get the SharedPreferences data anywhere, just use
  /// await SharedPreferences.getInstance()

  /// so restaurant_screen can get the prefs value
  late bool favPrefs;

  /// set init value for favPrefs,
  /// not for init SharedPreferences value
  setFavPref(String id) async {
    /// get SharedPreferences from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// get SharedPreferences data, if null set bool data to false (not
    /// the SharedPreferences)
    bool data = prefs.getBool('isFav$id') ?? false;

    /// data in here is always either true or false, never null because ?? false
    if (data == false) {
      favPrefs = false;
      notifyListeners();
      return favPrefs;
    } else {
      favPrefs = true;
      notifyListeners();
      return favPrefs;
    }
  }

  /// toggle favPref on or off from icon press
  void toggleFavPref(String id) async {
    SharedPreferences data = await SharedPreferences.getInstance();
    bool isFavValue = data.getBool('isFav$id') ?? false;

    /// data in here is always either true or false, never null because ?? false
    if (isFavValue == false) {
      data.setBool('isFav$id', true);
      favPrefs = true;
      notifyListeners();
    } else {
      data.setBool('isFav$id', false);
      favPrefs = false;
      notifyListeners();
    }
  }
}
