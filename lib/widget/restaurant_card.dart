import 'package:flutter/material.dart';
import 'package:restaurant_app_1/page/restaurant_screen.dart';
import 'package:restaurant_app_1/data/model/restaurants.dart';

class RestaurantCard extends StatelessWidget {
  final String restaurantId;
  final String restaurantName;
  final String restaurantCity;
  final String restaurantDescription;
  final String restaurantPictureId;
  final double restaurantRating;
  final List<Food> restaurantFoods;
  final List<Drink> restaurantDrinks;

  const RestaurantCard(
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
    /// Each Restaurant List
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, left: 16, right: 16, bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return RestaurantScreen(
              restaurantName: restaurantName,
              restaurantCity: restaurantCity,
              restaurantDescription: restaurantDescription,
              restaurantId: restaurantId,
              restaurantPictureId: restaurantPictureId,
              restaurantRating: restaurantRating,
              restaurantDrinks: restaurantDrinks,
              restaurantFoods: restaurantFoods,
            );
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
            /// Restaurant Img
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(restaurantPictureId),
                  ),
                ),
              ),
            ),

            /// Restaurant Name
            title: Text(
              restaurantName,
              style: const TextStyle(color: Colors.white),
            ),

            /// Restaurant Location
            subtitle: Text(
              restaurantCity,
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
                  restaurantRating.toString(),
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
