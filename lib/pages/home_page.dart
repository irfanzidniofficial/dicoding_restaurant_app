import 'dart:convert';

import 'package:dicoding_restaurant_app/data/models/restaurants.dart';
import 'package:dicoding_restaurant_app/pages/detail_page.dart';
import 'package:dicoding_restaurant_app/utils/style.dart';
import 'package:dicoding_restaurant_app/widgets/list_restaurant_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Restaurant> allRestaurants = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    _fetchRestaurants(context);
  }

  Future<void> _fetchRestaurants(BuildContext context) async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/json/local_restaurant.json");

    ListRestaurant listRestaurant =
        ListRestaurant.fromMap(json.decode(jsonData));

    setState(() {
      allRestaurants = listRestaurant.restaurants;
    });
  }

  List<Restaurant> get filteredRestaurants {
    if (query.isEmpty) {
      return allRestaurants;
    } else {
      return allRestaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isSrolled) {
          return [
            SliverAppBar(
              backgroundColor: primaryColor,
              automaticallyImplyLeading: false,
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.asset(
                  "assets/images/banner.png",
                  fit: BoxFit.cover,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      hintText: "Search",
                      hintStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: filteredRestaurants.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                    ),
                    child: Text(
                      "No Restaurant Found",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const PageScrollPhysics(),
                  itemCount: filteredRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = filteredRestaurants[index];

                    return ListRestaurantCardWidget(
                      onPress: () {
                        Navigator.pushNamed(
                          context,
                          DetailPage.routeName,
                          arguments: restaurant,
                        );
                      },
                      name: restaurant.name,
                      address: restaurant.city,
                      image: restaurant.pictureId,
                      star: restaurant.rating.toString(),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
