import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  PreferencesHelper({required this.sharedPreferences});

  static const scheduleRestaurant = 'SCHEDULED_RESTAURANT';

  Future<bool> get isScheduledRestaurant async {
    final prefs = await sharedPreferences;
    return prefs.getBool(scheduleRestaurant) ?? false;
  }

  void setScheduledRestaurant(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(scheduleRestaurant, value);
  }
}
