import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/widget/favorite_icon.dart';
import 'package:restaurant_app_1/widget/menu_item_name.dart';
import 'package:restaurant_app_1/widget/my_divider.dart';

class RestaurantDetailBuilder extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantDetailBuilder({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    const String medImg = "https://restaurant-api.dicoding.dev/images/medium/";
    final int resFoodsLen = restaurant.menus.foods.length;
    final int resDrinksLen = restaurant.menus.drinks.length;
    final int tagLen = restaurant.categories.length;
    final int reviewLen = restaurant.customerReviews.length;
    return SafeArea(
      child: ListView(
        children: <Widget>[
          /// Main Image
          Hero(
            tag: restaurant.id,

            /// Added Loading builder to show loading screen
            child: Image.network(
              (medImg + restaurant.pictureId),
              loadingBuilder: (context, child, loadingProgress) {
                /// When it's done loading
                if (loadingProgress == null) return child;

                /// While still loading
                return const Center(child: CircularProgressIndicator());
              },

              /// When error
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text("Error loading image")),
                );
              },
            ),
          ),

          /// Padding for all content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                //
                /// Top Content
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
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

                          /// Address
                          Text(
                            restaurant.address,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 12, height: 1.5),
                          ),
                        ],
                      ),
                    ),

                    /// Restaurant rating
                    Flexible(
                      flex: 1,
                      child: Row(
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
                    ),

                    /// Favorite Icon
                    Flexible(
                      flex: 1,
                      child: FavoriteIcon(restaurant: restaurant),
                    ),
                  ],
                ),

                const MyDivider(),

                /// Category
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < tagLen; i++)
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Chip(
                          label: Text(
                            restaurant.categories[i].name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          backgroundColor: const Color.fromRGBO(255, 139, 139, 1),
                        ),
                      ),
                  ],
                ),

                const MyDivider(),

                /// Description
                Text(
                  restaurant.description,
                  style: const TextStyle(fontSize: 15),
                ),

                const MyDivider(),

                /// Menu Title
                const Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// Food Title
                const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 16),
                    child: Text(
                      "Food",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                /// Food Item
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: <Widget>[
                      for (int i = 0; i < resFoodsLen; i++)
                        MenuItemName(itemName: restaurant.menus.foods[i].name),
                    ],
                  ),
                ),

                /// Drink Title
                const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      "Drink",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                /// Drink Item
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: <Widget>[
                      for (int i = 0; i < resDrinksLen; i++)
                        MenuItemName(itemName: restaurant.menus.drinks[i].name),
                    ],
                  ),
                ),

                const MyDivider(),

                /// Review Item
                Column(
                  children: <Widget>[
                    for (int i = 0; i < reviewLen; i++)
                      ListTile(
                        leading: const Icon(
                          Icons.reviews_rounded,
                          color: Colors.pink,
                        ),
                        title: Text(restaurant.customerReviews[i].review),
                        subtitle: Text(restaurant.customerReviews[i].name),
                        trailing: Text(restaurant.customerReviews[i].date),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
