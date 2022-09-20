import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/model/restaurant_model.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  static const String _detailQuery = "/detail/";
  static const String _listQuery = "/list";
  static const String _searchQuery = "/search?q=";

  /// for adding review
  static const String _reviewQuery = "/review";

  /// for [HomeScreen]
  Future<RestaurantsList> getRestaurantsList() async {
    final response = await http.get(Uri.parse(_baseUrl + _listQuery));
    if (response.statusCode == 200) {
      /// jsonDecode => change from String format to JSON format
      /// fromJSON => change from JSOn format to RestaurantModel object
      return RestaurantsList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant list from API -_-");
    }
  }

  /// for [HomeScreen]
  Future<Restaurants> getRestaurantsDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detailQuery + id));
    if (response.statusCode == 200) {
      return Restaurants.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant detail -_-");
    }
  }

  /// for [HomeScreen]
  Future<Restaurants> getSearchResults(String searchText) async {
    final response =
        await http.get(Uri.parse(_baseUrl + _searchQuery + searchText));
    if (response.statusCode == 200) {
      return Restaurants.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load search result -_-");
    }
  }

  /// for [RestaurantScreen]
  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detailQuery + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant detail -_-");
    }
  }

  /// for [RestaurantScreen]
  Future<Restaurant> getRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detailQuery + id));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant detail -_-");
    }
  }
}
