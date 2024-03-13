import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/review.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, success, error }

class ReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  ReviewProvider({required this.apiService});
  late ReviewResult _reviewResult;
  late ResultState _state;
  late Map<dynamic, dynamic> _data;

  ReviewResult get result => _reviewResult;

  ResultState get state => _state;

  Future<dynamic> addReview() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final review = await apiService.addReview(_data);
      if (review.error == false) {
        notifyListeners();
        return _state = ResultState.error;
      } else {
        notifyListeners();
        return _state = ResultState.success;
      }
    } catch (e) {
      notifyListeners();
      return _state = ResultState.error;
    }
  }

  void createData({String? name, String? review, String? restaurantId}) {
    _data = {
      'id': restaurantId,
      'name': name,
      'review': review,
    };
    notifyListeners();
  }
}
