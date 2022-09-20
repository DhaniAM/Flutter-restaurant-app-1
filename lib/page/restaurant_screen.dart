import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/widget/menu_item_name.dart';

class RestaurantScreen extends StatelessWidget {
  final String restaurantId;

  const RestaurantScreen({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const medImg = "https://restaurant-api.dicoding.dev/images/medium/";

    Divider myDivider = const Divider(
      color: Color.fromRGBO(255, 175, 175, 0.8),
      thickness: 2,
      height: 0,
      indent: 25,
      endIndent: 25,
    );

    return FutureBuilder(
      future: ApiService().getRestaurantDetail(restaurantId),
      builder: (context, data) {
        if (data.hasData) {
          late RestaurantDetail restaurantDetail =
              data.data as RestaurantDetail;
          Restaurant restaurant = restaurantDetail.restaurant;
          final int resFoodsLen = restaurant.menus.foods.length;
          final int resDrinksLen = restaurant.menus.drinks.length;
          return Scaffold(
            appBar: AppBar(
              title: Text(restaurantDetail.restaurant.name),
              backgroundColor: const Color.fromRGBO(255, 106, 106, 1),
            ),
            body: SafeArea(
              child: ListView(
                children: <Widget>[
                  /// Top Image
                  Hero(
                    tag: restaurant.pictureId,
                    child: Image.network((medImg + restaurant.pictureId),
                        loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    }),
                  ),

                  /// Title Content
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
                                restaurant.name,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              /// Restaurant City
                              Text(
                                restaurant.city,
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
                              restaurant.rating.toString(),
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
                      restaurant.description,
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
                        for (int i = 0; i < resFoodsLen; i++)
                          MenuItemName(
                              itemName: restaurant.menus.foods[i].name),
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
                        for (int i = 0; i < resDrinksLen; i++)
                          MenuItemName(
                              itemName: restaurant.menus.drinks[i].name),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (data.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error Loading Data -_-'),
            ),
          );
        } else {
          /// While Loading, show loading screen
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 106, 106, 1)),
            ),
          );
        }
      }, // builder
    );
  }
}
