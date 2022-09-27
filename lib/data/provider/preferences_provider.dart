import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/preferences/preferences_helper.dart';

/// ALl Provider can only be accessed from Consumer or Provider.of inside ChangeNotifierProvider
class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  PreferencesProvider({required this.preferencesHelper}) {
    _getIsScheduledRestaurant();
  }

  bool _isScheduledRestaurant = false;
  bool get isScheduledRestaurant => _isScheduledRestaurant;

  void _getIsScheduledRestaurant() async {
    _isScheduledRestaurant = await preferencesHelper.isScheduledRestaurant;
    notifyListeners();
  }

  void toggleScheduledRestaurant(bool value) {
    preferencesHelper.setScheduledRestaurant(value);
    _getIsScheduledRestaurant();
  }
}
