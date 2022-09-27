import 'dart:math';
import 'dart:ui';
import 'dart:isolate';
import 'package:restaurant_app_1/main.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();

    /// get restaurants list
    var restaurantsList = await ApiService().getRestaurantsList();
    List restaurantIdList = restaurantsList.restaurants.toList();

    /// get random item
    var randomIndex = Random().nextInt(restaurantIdList.length);
    var randomRestaurant = restaurantsList.restaurants[randomIndex].id;
    var restaurantDetail = await ApiService().getRestaurantDetail(randomRestaurant);

    /// get the restaurant
    /// so restaurant object here is already created, no need to make new one
    var restaurant = restaurantDetail.restaurant;

    /// show notification and pass the restaurant to notification
    await notificationHelper.showNotification(flutterLocalNotificationsPlugin, restaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
