import 'dart:convert';
import 'package:flutter/services.dart';

class ParseData {
  static Future<String> _loadFromAsset() async {
    /// Load the JSON file
    return await rootBundle.loadString("assets/local_restaurant.json");
  }

  static Future parseJson() async {
    String jsonString = await _loadFromAsset();

    /// Parse the JSON file
    final restaurantData = jsonDecode(jsonString)["restaurants"];

    /// add the JSON data to restaurants
    List<String> restaurants = List.from(restaurantData);
    return restaurants;
  }
}
