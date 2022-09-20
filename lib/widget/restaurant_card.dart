import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';
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
    String smallImg = "https://restaurant-api.dicoding.dev/images/small/";

    /// Each Restaurant List
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, left: 16, right: 16, bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return RestaurantScreen(
                restaurantId: restaurantsList.restaurants[index].id);
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
            /// Restaurant Image
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(smallImg +
                        restaurantsList.restaurants[index].pictureId),
                  ),
                ),
              ),
            ),

            /// Restaurant Name
            title: Text(
              restaurantsList.restaurants[index].name,
              style: const TextStyle(color: Colors.white),
            ),

            /// Restaurant Location
            subtitle: Text(
              restaurantsList.restaurants[index].city,
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
                  restaurantsList.restaurants[index].rating.toString(),
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
