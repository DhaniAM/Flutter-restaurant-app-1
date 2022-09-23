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
    getFavPref(resId);
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

  bool? favPrefs;

  getFavPref(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool data = prefs.getBool('isFav$id') ?? false;
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

  void addFavPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFavorite', true);
    notifyListeners();
  }

  void removeFavPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isFavorite');
    notifyListeners();
  }

  /// toggle favPref on or off
  void toggleFavPref(String id) async {
    SharedPreferences isFav = await SharedPreferences.getInstance();
    // if null, then set to 'false'
    bool isFavValue = isFav.getBool('isFav$id') ?? false;
    if (isFavValue == false) {
      isFav.setBool('isFav$id', true);
      favPrefs = true;
      notifyListeners();
    } else {
      isFav.setBool('isFav$id', false);
      favPrefs = false;
      notifyListeners();
    }
  }
}
