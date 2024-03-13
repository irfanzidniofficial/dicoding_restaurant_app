
import 'dart:convert';

class ReviewResult {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  ReviewResult({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  ReviewResult copyWith({
    bool? error,
    String? message,
    List<CustomerReview>? customerReviews,
  }) =>
      ReviewResult(
        error: error ?? this.error,
        message: message ?? this.message,
        customerReviews: customerReviews ?? this.customerReviews,
      );

  factory ReviewResult.fromJson(String str) =>
      ReviewResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReviewResult.fromMap(Map<String, dynamic> json) => ReviewResult(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toMap())),
      };
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  CustomerReview copyWith({
    String? name,
    String? review,
    String? date,
  }) =>
      CustomerReview(
        name: name ?? this.name,
        review: review ?? this.review,
        date: date ?? this.date,
      );

  factory CustomerReview.fromJson(String str) =>
      CustomerReview.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerReview.fromMap(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "review": review,
        "date": date,
      };
}
