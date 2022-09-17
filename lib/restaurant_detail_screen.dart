import 'package:flutter/material.dart';
import 'package:restaurant_app_1/menu_item_name.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            /// Top Image
            Image.asset(
              "asset/img-test.jpg",
            ),

            /// Restaurant Name
            Text("Restaurant Name"),

            /// Location
            Text("City"),

            /// Description
            Text("Description Title"),
            Text("Description"),

            /// Menu
            Text("Menu Title"),

            /// Menu name
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: <Widget>[
                MenuItemName(),
                MenuItemName(),
                MenuItemName(),
                MenuItemName(),
                MenuItemName(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
