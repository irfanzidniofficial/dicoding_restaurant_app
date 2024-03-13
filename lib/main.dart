import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/pages/splash_page.dart';

import 'package:dicoding_restaurant_app/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/provider/review_provider.dart';
import 'package:dicoding_restaurant_app/provider/search_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/router/app_router.dart';
import 'package:dicoding_restaurant_app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (context) => RestaurantProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<ReviewProvider>(
          create: (context) => ReviewProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (context) => SearchRestaurantProvider(
            apiService: ApiService(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                secondary: Colors.lightBlue,
                onPrimary: blackColor,
              ),
          textTheme: myTextTheme,
        ),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: SplashPage.routeName,
      ),
    );
  }
}
