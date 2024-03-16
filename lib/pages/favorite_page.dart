import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/pages/detail_page.dart';
import 'package:dicoding_restaurant_app/provider/database_provider.dart';
import 'package:dicoding_restaurant_app/widgets/list_restaurant_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite_page';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Favorite",
        ),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, databaseState, _) {
          final savedRestaurants = databaseState.saved;

          if (savedRestaurants.isEmpty) {
            return const Center(
              child: Text('Belum ada restoran yang disimpan'),
            );
          }

          return ListView.builder(
            itemCount: savedRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = savedRestaurants[index];
              return ListRestaurantCardWidget(
                name: restaurant.name,
                pictureId: restaurant.pictureId,
                address: restaurant.city,
                restaurantId: restaurant.id,
                image:
                    "${ApiService.baseUrl}images/medium/${restaurant.pictureId}",
                star: restaurant.rating.toString(),
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailPage(
                          restaurantId: restaurant.id,
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
