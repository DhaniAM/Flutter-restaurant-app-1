import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  String resId;
  FavoriteProvider({required this.resId}) {
    setFavPref(resId);
  }

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
