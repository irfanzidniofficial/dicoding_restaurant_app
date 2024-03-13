import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/search_restaurant.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    _fetchAllSearchRestaurant();
  }

  late SearchRestaurantResult _searchrestaurantResult;
  late ResultState _state;
  String _message = '';
  String _searchquerry = '';

  String get message => _message;

  SearchRestaurantResult get result => _searchrestaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllSearchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final searchrestaurant = await apiService.searchRestaurant(_searchquerry);
      notifyListeners();
      if (searchrestaurant.error == true && searchrestaurant.founded == 0) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchrestaurantResult = searchrestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }

  void changeSearchString(String searchString) {
    _searchquerry = searchString;
    notifyListeners();
    _fetchAllSearchRestaurant();
  }
}
