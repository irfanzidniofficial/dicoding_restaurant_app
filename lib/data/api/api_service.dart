import 'package:dicoding_restaurant_app/data/models/detail_restaurant.dart';
import 'package:dicoding_restaurant_app/data/models/restaurants.dart';
import 'package:dicoding_restaurant_app/data/models/review.dart';
import 'package:dicoding_restaurant_app/data/models/search_restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail';
  static const String _search = 'search?q=';
  static const String _review = 'review';

  static String get baseUrl => _baseUrl;

  Future<RestaurantResult> listRestaurant() async {
    final response = await http.get(Uri.parse("$_baseUrl$_list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(response.body);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<DetailRestaurantResult> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl$_detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(response.body);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<SearchRestaurantResult> searchRestaurant(String name) async {
    final response = await http.get(Uri.parse("$_baseUrl$_search$name"));
    if (response.statusCode == 200) {
      return SearchRestaurantResult.fromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ReviewResult> addReview(Map<dynamic, dynamic> data) async {
    final response =
        await http.post(Uri.parse("$_baseUrl$_review"), body: data);
    if (response.statusCode == 200) {
      return ReviewResult.fromJson(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
