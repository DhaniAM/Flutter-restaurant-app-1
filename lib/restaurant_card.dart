import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromRGBO(255, 139, 139, 1),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
          ),
          title: Text("Restaurant Name"),
          subtitle: Text("Location"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star_rounded,
                color: Colors.yellow,
              ),
              Text("4.5"),
            ],
          ),
        ),
      ),
    );
  }
}
