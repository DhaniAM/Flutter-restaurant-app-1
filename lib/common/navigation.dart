import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static intentWithoutData(routeName) {
    navigatorKey.currentState?.push(routeName);
  }

  static back() => navigatorKey.currentState?.pop();
}
