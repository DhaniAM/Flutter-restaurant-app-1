import 'package:flutter/material.dart';
import 'package:restaurant_app_1/page/restaurant_screen.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantsList restaurantsList;
  final int index;

  const RestaurantCard(
      {Key? key, required this.restaurantsList, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String smallImg = "https://restaurant-api.dicoding.dev/images/small/";

    /// to shortened the link to access the object
    final Restaurants restaurant = restaurantsList.restaurants[index];

    /// Each Restaurant List
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 4),

      /// Routing
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return RestaurantScreen(restaurantId: restaurant.id);
          })));
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
          child: ListTile(
            //
            /// Restaurant Image
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 80,
                width: 80,
                child: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    (smallImg + restaurant.pictureId),
                    loadingBuilder: (context, child, loadingProgress) {
                      /// When it's done loading
                      if (loadingProgress == null) return child;

                      /// While still loading
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Column(
                        children: const <Widget>[
                          Icon(Icons.warning_rounded),
                          Text("Img Error")
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

            /// Restaurant Name
            title: Text(
              restaurant.name,
              style: const TextStyle(color: Colors.white),
            ),

            /// Restaurant Location
            subtitle: Text(
              restaurant.city,
              style: const TextStyle(color: Colors.white),
            ),

            /// Restaurant Rating
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.star_rounded,
                  color: Colors.yellow,
                ),
                Text(
                  restaurant.rating.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
