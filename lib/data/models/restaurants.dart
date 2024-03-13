import 'dart:convert';

class RestaurantResult {
    final bool error;
    final String message;
    final int count;
    final List<Restaurant> restaurants;

    RestaurantResult({
        required this.error,
        required this.message,
        required this.count,
        required this.restaurants,
    });

    RestaurantResult copyWith({
        bool? error,
        String? message,
        int? count,
        List<Restaurant>? restaurants,
    }) => 
        RestaurantResult(
            error: error ?? this.error,
            message: message ?? this.message,
            count: count ?? this.count,
            restaurants: restaurants ?? this.restaurants,
        );

    factory RestaurantResult.fromJson(String str) => RestaurantResult.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RestaurantResult.fromMap(Map<String, dynamic> json) => RestaurantResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "count": count,
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

    factory Restaurant.fromJson(String str) => Restaurant.fromMap(json.decode(str));

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
