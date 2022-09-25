import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/db/database_helper.dart';
import 'package:restaurant_app_1/data/provider/database_provider.dart';
import 'package:restaurant_app_1/data/provider/home_provider.dart';
import 'package:restaurant_app_1/data/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app_1/data/provider/scheduling_provider.dart';
import 'package:restaurant_app_1/data/provider/search_provider.dart';
import 'package:restaurant_app_1/page/main_screen.dart';
import 'package:restaurant_app_1/page/restaurant_screen.dart';
import 'package:restaurant_app_1/page/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      ],
      child: MaterialApp(
        title: "Local Restaurant",
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(255, 106, 106, 1),
          splashColor: const Color.fromRGBO(67, 218, 239, 1),
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const MainScreen(),
          RestaurantScreen.routeName: (context) => const RestaurantScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
        },
      ),
    );
  }
}
