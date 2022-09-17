import 'package:flutter/material.dart';
import 'package:restaurant_app_1/restaurant_screen.dart';
import 'package:restaurant_app_1/restaurants.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8),
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(255, 139, 139, 1),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromARGB(255, 189, 189, 189),
                blurRadius: 0.2,
                offset: Offset(2, 2),
              )
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(restaurantPictureId),
            ),
            title: Text(
              restaurantName,
            ),
            subtitle: Text(restaurantCity),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.star_rounded,
                  color: Colors.yellow,
                ),
                Text(restaurantRating.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
