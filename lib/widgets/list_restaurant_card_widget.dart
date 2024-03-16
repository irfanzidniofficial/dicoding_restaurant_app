import 'package:dicoding_restaurant_app/data/models/restaurants.dart';
import 'package:dicoding_restaurant_app/provider/database_provider.dart';
import 'package:dicoding_restaurant_app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRestaurantCardWidget extends StatelessWidget {
  final String name;
  final String address;
  final String image;
  final String star;
  final String pictureId;

  final String restaurantId;

  final Function()? onPress;

  const ListRestaurantCardWidget({
    Key? key,
    required this.name,
    required this.address,
    required this.image,
    required this.star,
    required this.onPress,
    required this.restaurantId,
    required this.pictureId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSaved = Provider.of<DatabaseProvider>(context)
        .saved
        .any((r) => r.id == restaurantId);

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.withOpacity(0.4),
        ),
      ),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 3),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        onTap: onPress,
        leading: Hero(
          tag: image,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.verified_user,
              color: primaryColor,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                name,
                style: myTextTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              const Row(
                children: [],
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.red.shade500,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    address,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 16,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(star),
                ],
              )
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            final databaseProvider =
                Provider.of<DatabaseProvider>(context, listen: false);
            if (isSaved) {
              databaseProvider.removeSaved(restaurantId);
            } else {
              final restaurant = Restaurant(
                id: restaurantId,
                name: name,
                description: '',
                pictureId: pictureId,
                city: address,
                rating: double.parse(star),
              );
              databaseProvider.addSaved(restaurant);
            }
          },
          icon: Icon(
            isSaved ? Icons.favorite_rounded : Icons.favorite_outline,
            color: isSaved ? Colors.red : null,
          ),
        ),
      ),
    );
  }
}
