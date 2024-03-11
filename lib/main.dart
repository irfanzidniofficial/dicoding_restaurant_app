import 'package:dicoding_restaurant_app/pages/splash_page.dart';
import 'package:dicoding_restaurant_app/router/app_router.dart';
import 'package:dicoding_restaurant_app/utils/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
