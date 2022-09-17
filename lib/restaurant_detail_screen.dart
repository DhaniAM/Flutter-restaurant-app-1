import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: <Widget>[
          Image.asset(
            "asset/img-test.jpg",
            height: 200,
          ),
          Text("hello"),
          Text("hello"),
          Text("hello"),
          Text("hello"),
          Text("hello"),
        ]),
      ),
    );
  }
}
