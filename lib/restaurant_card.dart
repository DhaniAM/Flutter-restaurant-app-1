import 'package:flutter/material.dart';
import 'package:restaurant_app_1/restaurant_detail_screen.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return RestaurantDetailScreen();
          })));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromRGBO(255, 139, 139, 1),
          ),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
            ),
            title: Text("Restaurant Name"),
            subtitle: Text("Location"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(
                  Icons.star_rounded,
                  color: Colors.yellow,
                ),
                Text("4.5"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
