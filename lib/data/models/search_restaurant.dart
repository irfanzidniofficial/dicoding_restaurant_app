import 'dart:convert';

class SearchRestaurantResult {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  SearchRestaurantResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  SearchRestaurantResult copyWith({
    bool? error,
    int? founded,
    List<Restaurant>? restaurants,
  }) =>
      SearchRestaurantResult(
        error: error ?? this.error,
        founded: founded ?? this.founded,
        restaurants: restaurants ?? this.restaurants,
      );

  factory SearchRestaurantResult.fromJson(String str) =>
      SearchRestaurantResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchRestaurantResult.fromMap(Map<String, dynamic> json) =>
      SearchRestaurantResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toMap())),
      };
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? pictureId,
    String? city,
    double? rating,
  }) =>
      Restaurant(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        pictureId: pictureId ?? this.pictureId,
        city: city ?? this.city,
        rating: rating ?? this.rating,
      );

  factory Restaurant.fromJson(String str) =>
      Restaurant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
