import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/common/navigation.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/db/database_helper.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/data/preferences/preferences_helper.dart';
import 'package:restaurant_app_1/data/provider/database_provider.dart';
import 'package:restaurant_app_1/data/provider/home_provider.dart';
import 'package:restaurant_app_1/data/provider/preferences_provider.dart';
import 'package:restaurant_app_1/data/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app_1/data/provider/scheduling_provider.dart';
import 'package:restaurant_app_1/data/provider/search_provider.dart';
import 'package:restaurant_app_1/page/home_screen.dart';
import 'package:restaurant_app_1/page/main_screen.dart';
import 'package:restaurant_app_1/page/restaurant_screen.dart';
import 'package:restaurant_app_1/page/search_screen.dart';
import 'package:restaurant_app_1/utils/background_service.dart';
import 'package:restaurant_app_1/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// [ChangeNotifierProvider] is used so we can use the [Consumer]
    /// so we can use the state
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (context) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (context) => RestaurantDetailProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (context) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (context) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: "Local Restaurant",
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(255, 106, 106, 1),
          splashColor: const Color.fromRGBO(67, 218, 239, 1),
        ),
        navigatorKey: navigatorKey,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const MainScreen(),
          RestaurantScreen.routeName: (context) => RestaurantScreen(
              restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant),
          SearchScreen.routeName: (context) => const SearchScreen(),
        },
      ),
    );
  }
}
