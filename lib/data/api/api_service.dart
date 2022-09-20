import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_1/data/model/restaurants_model.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  static const String _detailQuery = "/detail/";
  static const String _listQuery = "/list";
  static const String _searchQuery = "/search?q=";
  static const String _reviewQuery = "/review";

  Future<RestaurantsModel> getRestaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + _listQuery));
    if (response.statusCode == 200) {
      /// jsonDecode => change from String format to JSON format
      /// fromJSON => change from JSOn format to RestaurantModel object
      return RestaurantsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant list from API -_-");
    }
  }

  Future<Restaurant> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detailQuery + id));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant detail -_-");
    }
  }

  Future<Restaurant> getSearchResult(String searchText) async {
    final response = await http.get(Uri.parse(_baseUrl + searchText));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load search result -_-");
    }
  }
}
