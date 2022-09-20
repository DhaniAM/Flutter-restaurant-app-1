import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/widget/menu_item_name.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';

class RestaurantScreen extends StatelessWidget {
  final RestaurantDetail restaurant;

  const RestaurantScreen({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int resFoodLen = restaurant.restaurant.menus.foods.length;
    int resDrinkLen = restaurant.restaurant.menus.drinks.length;

    Divider myDivider = const Divider(
      color: Color.fromRGBO(255, 175, 175, 0.8),
      thickness: 2,
      height: 0,
      indent: 25,
      endIndent: 25,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.restaurant.name),
        backgroundColor: const Color.fromRGBO(255, 106, 106, 1),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            /// Top Image
            Image.network(restaurant.restaurant.pictureId,
                loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            }),

            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Restaurant Name
                        Text(
                          restaurant.restaurant.name,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        /// Restaurant City
                        Text(
                          restaurant.restaurant.city,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),

                  /// Restaurant rating
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.yellow,
                      ),
                      Text(
                        restaurant.restaurant.rating.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            myDivider,

            /// Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                restaurant.restaurant.description,
                style: const TextStyle(fontSize: 15),
              ),
            ),

            myDivider,

            /// Menu Title
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            /// Foods Title
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Food",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// Foods Item
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                children: <Widget>[
                  for (int i = 0; i < resFoodLen; i++)
                    MenuItemName(
                        itemName: restaurant.restaurant.menus.foods[i].name),
                ],
              ),
            ),

            /// Drinks Title
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Drink",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// Drinks Item
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                children: <Widget>[
                  for (int i = 0; i < resDrinkLen; i++)
                    MenuItemName(
                        itemName: restaurant.restaurant.menus.drinks[i].name),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
