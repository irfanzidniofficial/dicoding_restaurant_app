import 'dart:async';

import 'package:dicoding_restaurant_app/provider/search_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
          Timer(const Duration(seconds: 2), () {
                Provider.of<SearchRestaurantProvider>(context, listen: false)
                    .changeSearchString(value);
              });
            },
          ),
        ),
      ),
    );
  }
}
