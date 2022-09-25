import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  /// to get
  /// /// CHANGE THIS LATER
  bool? _isFav;
  late FavoriteState _currentState;
  late String _message;

  /// Getter
  bool? get isFav => _isFav;
  FavoriteState get currentState => _currentState;

  /// Setter
  set setIsFav(bool value) {
    _isFav = value;
    notifyListeners();
  }

  Future isFavPref(String id) async {
    try {
      _currentState = FavoriteState.loading;
      final SharedPreferences data = await SharedPreferences.getInstance();
      final bool pref = data.getBool('isFav$id') ?? false;
      _currentState = FavoriteState.hasData;
      return pref;
    } catch (e) {
      return _message = 'Error no data -_-';
    }
  }

  /// toggle favPref on or off from icon press
  void toggleFavPref(String id) async {
    _currentState = FavoriteState.loading;
    final SharedPreferences data = await SharedPreferences.getInstance();
    final bool isFavValue = data.getBool('isFav$id') ?? false;

    /// data in here is always either true or false, never null because ?? false
    if (isFavValue == false) {
      data.setBool('isFav$id', true);
      _isFav = true;
      _currentState = FavoriteState.hasData;
      notifyListeners();
    } else {
      data.setBool('isFav$id', false);
      _isFav = false;
      _currentState = FavoriteState.hasData;
      notifyListeners();
    }
  }
}
