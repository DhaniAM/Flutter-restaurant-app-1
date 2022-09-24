import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum FavoriteState { loading, hasData }

class FavoriteProvider extends ChangeNotifier {
  /// to get
  /// /// CHANGE THIS LATER
  bool? _isFav;
  late FavoriteState _currentState;

  /// Getter
  bool? get isFav => _isFav;
  FavoriteState get currentState => _currentState;

  set setIsFav(bool value) {
    _isFav = value;
    notifyListeners();
  }

  /// set init value for favPrefs,
  /// not for init SharedPreferences value
  void _setFavPref(String id) async {
    _currentState = FavoriteState.loading;

    /// get SharedPreferences from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// get SharedPreferences data, if null set bool data to false (not
    /// the SharedPreferences)
    bool data = prefs.getBool('isFav$id') ?? false;

    /// data in here is always either true or false, never null because ?? false
    if (data == false) {
      _isFav = false;
      _currentState = FavoriteState.hasData;
      notifyListeners();
    } else {
      _isFav = true;
      _currentState = FavoriteState.hasData;
      notifyListeners();
    }
  }

  Future<bool> isFavPref(String id) async {
    _currentState = FavoriteState.loading;
    final SharedPreferences data = await SharedPreferences.getInstance();
    final bool pref = data.getBool('isFav$id') ?? false;
    _currentState = FavoriteState.hasData;
    return pref;
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
