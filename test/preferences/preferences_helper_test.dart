import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app_1/data/preferences/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  test('check is preference helper change the sharedPrefence value', () async {
    // init
    var expectedResult = true;
    var value = true;

    // test
    var prefs = PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());
    prefs.setScheduledRestaurant(value);

    // assert
    var result = await prefs.isScheduledRestaurant;
    expect(result, expectedResult);
  });
}
