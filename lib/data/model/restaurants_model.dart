import 'dart:convert';

/// class for restaurant list in [HomeScreen] and [SearchScreen]
RestaurantsList restaurantsDataFromJson(String str) => RestaurantsList.fromJson(json.decode(str));

class RestaurantsList {
  RestaurantsList(
      {required this.error, this.message, this.count, required this.restaurants, this.founded});

  bool error;
  int? count;
  String? message;
  int? founded;
  List<Restaurants> restaurants;

  factory RestaurantsList.fromJson(Map<String, dynamic> json) {
    /// for [SearchScreen] result
    if (json["message"] == null) {
      return RestaurantsList(
        error: json["error"],
        founded: json["founded"],
        restaurants:
            List<Restaurants>.from(json["restaurants"].map((x) => Restaurants.fromJson(x))),
      );

      /// for [HomeScreen] result
    } else if (json["founded"] == null) {
      return RestaurantsList(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants:
            List<Restaurants>.from(json["restaurants"].map((x) => Restaurants.fromJson(x))),
      );
    } else {
      throw Exception("Error loading API");
    }
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<Restaurants>.from(restaurants.map((x) => x.toJson())),
      };
}

/// Overview of Restaurants detail, not so complete compared to [Restaurant] class
class Restaurants {
  Restaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
