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
    const String medImg = "https://restaurant-api.dicoding.dev/images/medium/";

    /// Line divider
    Divider myDivider = const Divider(
      color: Color.fromRGBO(255, 175, 175, 0.8),
      thickness: 1,
      height: 24,
      indent: 5,
      endIndent: 5,
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
          final int tagLen = restaurant.categories.length;
          final int reviewLen = restaurant.customerReviews.length;

          return Scaffold(
            /// App Bar
            appBar: AppBar(
              title: Text(restaurantDetail.restaurant.name),
              backgroundColor: const Color.fromRGBO(255, 106, 106, 1),
            ),
            body: SafeArea(
              child: ListView(
                children: <Widget>[
                  //
                  /// Main Image
                  Hero(
                    tag: restaurant.pictureId,

                    /// Added Loading builder to show loading screen
                    child: Image.network(
                      (medImg + restaurant.pictureId),
                      loadingBuilder: (context, child, loadingProgress) {
                        /// When it's done loading
                        if (loadingProgress == null) return child;

                        /// While still loading
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 200,
                          child: Center(child: Text("Error loading image -_-")),
                        );
                      },
                    ),
                  ),

                  /// Padding for all content
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        /// Title Content
                        Row(
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

                                  /// Address
                                  Text(
                                    restaurant.address,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 12, height: 1.5),
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

                        myDivider,

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
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    backgroundColor:
                                        const Color.fromRGBO(255, 139, 139, 1)),
                              ),
                          ],
                        ),

                        myDivider,

                        /// Description
                        Text(
                          restaurant.description,
                          style: const TextStyle(fontSize: 15),
                        ),

                        myDivider,

                        /// Menu Title
                        const Text(
                          "Menu",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        /// Foods Title
                        const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 4),
                            child: Text(
                              "Food",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        /// Foods Item
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: <Widget>[
                              for (int i = 0; i < resFoodsLen; i++)
                                MenuItemName(
                                    itemName: restaurant.menus.foods[i].name),
                            ],
                          ),
                        ),

                        /// Drinks Title
                        const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, top: 8),
                            child: Text(
                              "Drink",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        /// Drinks Item
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: <Widget>[
                              for (int i = 0; i < resDrinksLen; i++)
                                MenuItemName(
                                    itemName: restaurant.menus.drinks[i].name),
                            ],
                          ),
                        ),

                        myDivider,

                        Column(
                          children: [
                            for (int i = 0; i < reviewLen; i++)
                              ListTile(
                                leading: Icon(
                                  Icons.reviews_rounded,
                                  color: Colors.pink,
                                ),
                                title:
                                    Text(restaurant.customerReviews[i].review),
                                subtitle:
                                    Text(restaurant.customerReviews[i].name),
                                trailing:
                                    Text(restaurant.customerReviews[i].date),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

          /// If can not load the [RestaurantDetail]
        } else if (data.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.warning_rounded, size: 50),
                  Text("Error loading data from internet."),
                  Text("Please check your internet connection."),
                  Text("-_-"),
                ],
              ),
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
