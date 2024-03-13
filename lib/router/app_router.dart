import 'package:dicoding_restaurant_app/pages/home_page.dart';
import 'package:dicoding_restaurant_app/pages/splash_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (_) => const SplashPage());
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
                Navigator.pushNamed(
                  _,
                  HomePage.routeName,
                );
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
