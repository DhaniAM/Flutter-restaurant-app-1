import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/provider/database_provider.dart';
import 'package:restaurant_app_1/page/restaurant_screen.dart';

/// Each Restaurant in [HomeScreen] and [SearchScreen]
class RestaurantCard extends StatelessWidget {
  /// for getting each [Restaurant], not for passing to [RestaurantScreen]
  final Restaurants restaurants;
  const RestaurantCard({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String smallImg = "https://restaurant-api.dicoding.dev/images/small/";

    /// Each Restaurant List
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 4),

      /// Routing
      /// pass Restaurant Id instead of index to get
      /// the [RestaurantDetail] on [RestaurantScreen]
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RestaurantScreen.routeName, arguments: restaurants.id);
        },

        /// Card Decoration
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(255, 139, 139, 1),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromARGB(255, 189, 189, 189),
                blurRadius: 3,
                offset: Offset(1, 3),
              )
            ],
          ),

          /// Card itself
          child: ListTile(
            /// Restaurant Image
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 80,
                width: 80,
                child: Hero(
                  tag: restaurants.pictureId,
                  child: Image.network(
                    (smallImg + restaurants.pictureId),

                    /// When it's done loading
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      /// While still loading
                      return const Center(
                          child:
                              CircularProgressIndicator(color: Color.fromRGBO(255, 106, 106, 1)));
                    },

                    /// When error
                    errorBuilder: (context, error, stackTrace) {
                      return Column(
                        children: const <Widget>[Icon(Icons.warning_rounded), Text("Img Error")],
                      );
                    },
                  ),
                ),
              ),
            ),

            /// Restaurant Name
            title: Text(
              restaurants.name,
              style: const TextStyle(color: Colors.white),
            ),

            /// Restaurant Location
            subtitle: Text(
              restaurants.city,
              style: const TextStyle(color: Colors.white),
            ),

            /// Restaurant Rating
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.yellow,
                    ),
                    Text(
                      restaurants.rating.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Consumer<DatabaseProvider>(
                      builder: (context, value, child) {
                        return FutureBuilder(
                          future: value.isBookmarked(restaurants.id),
                          builder: (context, snapshot) {
                            bool isBookmarked = snapshot.data ?? false;
                            if (isBookmarked) {
                              return const Icon(
                                Icons.favorite,
                                color: Colors.pink,
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
