import 'package:flutter/material.dart';
import 'package:restaurant_app_1/menu_item_name.dart';
import 'package:restaurant_app_1/restaurants.dart';

class RestaurantScreen extends StatelessWidget {
  final String restaurantId;
  final String restaurantName;
  final String restaurantCity;
  final String restaurantDescription;
  final String restaurantPictureId;
  final double restaurantRating;
  final List<Food> restaurantFoods;
  final List<Drink> restaurantDrinks;

  const RestaurantScreen(
      {Key? key,
      required this.restaurantName,
      required this.restaurantCity,
      required this.restaurantId,
      required this.restaurantDescription,
      required this.restaurantPictureId,
      required this.restaurantRating,
      required this.restaurantFoods,
      required this.restaurantDrinks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Divider myDivider = const Divider(
      color: Color.fromRGBO(255, 175, 175, 0.8),
      thickness: 2,
      height: 0,
      indent: 25,
      endIndent: 25,
    );
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            /// Top Image
            Image.network(restaurantPictureId,
                loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            }),

            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Restaurant Name
                  Text(
                    restaurantName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// Restaurant City
                  Text(
                    restaurantCity,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            myDivider,

            /// Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                restaurantDescription,
                style: const TextStyle(fontSize: 16),
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
                  for (int i = 0; i < restaurantFoods.length; i++)
                    MenuItemName(itemName: restaurantFoods[i].name),
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
                  for (int i = 0; i < restaurantDrinks.length; i++)
                    MenuItemName(itemName: restaurantDrinks[i].name),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
