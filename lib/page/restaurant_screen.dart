import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
import 'package:restaurant_app_1/data/provider/favorite_provier.dart';
import 'package:restaurant_app_1/data/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app_1/widget/menu_item_name.dart';
import 'package:restaurant_app_1/widget/my_divider.dart';
import 'package:restaurant_app_1/widget/state_message.dart';

class RestaurantScreen extends StatelessWidget {
  static const routeName = "/restaurantScreen";

  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;

    /// MultiProvider used to use multiple consumer
    return MultiProvider(
      providers: <ListenableProvider>[
        ListenableProvider<RestaurantDetailProvider>(
          create: (context) =>
              RestaurantDetailProvider(apiService: ApiService(), resId: id),
        ),
        ListenableProvider<FavoriteProvider>(
          create: (context) => FavoriteProvider(),
        ),
      ],

      /// used Consumer2 because we have 2 consumer to use
      child: Consumer2<RestaurantDetailProvider, FavoriteProvider>(
        builder: (context, resData, favData, child) {
          /// if Init or Loading state
          if (resData.currentState == RestoCurrentState.init ||
              resData.currentState == RestoCurrentState.loading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                    color: Color.fromRGBO(255, 106, 106, 1)),
              ),
            );

            /// No Data state
          } else if (resData.currentState == RestoCurrentState.noData) {
            return Scaffold(
                body:
                    StateMessage(icon: Icons.fastfood, text: resData.message));

            /// Error state
          } else if (resData.currentState == RestoCurrentState.error) {
            return Scaffold(
                body: StateMessage(
                    icon: Icons.cancel_rounded, text: resData.message));

            /// HasData state
          } else {
            final Restaurant restaurant = resData.restaurantDetail.restaurant;
            final int resFoodsLen = restaurant.menus.foods.length;
            final int resDrinksLen = restaurant.menus.drinks.length;
            final int tagLen = restaurant.categories.length;
            final int reviewLen = restaurant.customerReviews.length;

            bool isFav;

            /// getting is favorite for each restaurant
            favData.isFavPref(resData.resId).then((value) => {
                  if (value == true)
                    {
                      isFav = true,
                      favData.setIsFav = true,
                    }
                  else
                    {
                      isFav = false,
                      favData.setIsFav = false,
                    }
                });

            return Scaffold(
              /// App Bar Ttitle
              appBar: AppBar(
                title: Text(restaurant.name),
                backgroundColor: const Color.fromRGBO(255, 106, 106, 1),
              ),
              body: SafeArea(
                child: ListView(
                  children: <Widget>[
                    /// Main Image
                    Hero(
                      tag: restaurant.pictureId,

                      /// Added Loading builder to show loading screen
                      child: Image.network(
                        (resData.medImg + restaurant.pictureId),
                        loadingBuilder: (context, child, loadingProgress) {
                          /// When it's done loading
                          if (loadingProgress == null) return child;

                          /// While still loading
                          return const Center(
                              child: CircularProgressIndicator());
                        },
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
                          /// Title Content
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
                                      style: const TextStyle(
                                          fontSize: 12, height: 1.5),
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
                                child: (favData.isFav == true)
                                    ? IconButton(
                                        onPressed: () {
                                          favData.toggleFavPref(resData.resId);
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.pink,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          favData.toggleFavPref(resData.resId);
                                        },
                                        icon: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.grey,
                                        ),
                                      ),
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
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    backgroundColor:
                                        const Color.fromRGBO(255, 139, 139, 1),
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
                                  MenuItemName(
                                      itemName: restaurant.menus.foods[i].name),
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
                                  MenuItemName(
                                      itemName:
                                          restaurant.menus.drinks[i].name),
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
                                  title: Text(
                                      restaurant.customerReviews[i].review),
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
          }
        },
      ),
    );
  }
}
