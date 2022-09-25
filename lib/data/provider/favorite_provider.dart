import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// can only be used from Consumer or Provider.of
class FavoriteProvider extends ChangeNotifier {
  final String resId;
  FavoriteProvider({required this.resId}) {
    _isFavPref(resId);
  }

  bool? _isFav;
  late FavoriteState _currentState;

  /// Getter
  bool get isFav => _isFav ?? false;
  FavoriteState get currentState => _currentState;

  void _isFavPref(String id) async {
    try {
      final SharedPreferences data = await SharedPreferences.getInstance();

      /// if no data, the set to false, NEVER NULL
      final bool pref = data.getBool('isFav$id') ?? false;

      _isFav = pref;
      _currentState = FavoriteState.hasData;
      notifyListeners();
    } catch (e) {
      _currentState = FavoriteState.error;
      notifyListeners();
    }
  }

  /// toggle favPref on or off from icon press
  void toggleFavPref() async {
    try {
      final SharedPreferences data = await SharedPreferences.getInstance();
      final bool isFavValue = data.getBool('isFav$resId') ?? false;

      /// data in here is always either true or false, never null because ?? false
      if (isFavValue == false) {
        data.setBool('isFav$resId', true);
        _isFav = true;
        _currentState = FavoriteState.hasData;
        notifyListeners();
      } else {
        data.setBool('isFav$resId', false);
        _isFav = false;
        _currentState = FavoriteState.hasData;
        notifyListeners();
      }
    } catch (e) {
      _currentState = FavoriteState.error;
      notifyListeners();
    }
  }
}
