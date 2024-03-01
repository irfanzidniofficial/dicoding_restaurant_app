import 'package:dicoding_restaurant_app/data/models/restaurants.dart';
import 'package:dicoding_restaurant_app/pages/detail_page.dart';
import 'package:dicoding_restaurant_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case DetailPage.routeName:
        if (settings.arguments != null && settings.arguments is Restaurant) {
          final restaurant = settings.arguments as Restaurant;
          return MaterialPageRoute(
            builder: (_) => DetailPage(restaurant: restaurant),
          );
        }

        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text('Page not found'),
            ),
            ElevatedButton(
              onPressed: () {
                HomePage.routeName;
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
