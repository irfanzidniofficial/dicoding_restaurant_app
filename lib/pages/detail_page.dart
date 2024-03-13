import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/detail_restaurant.dart';
import 'package:dicoding_restaurant_app/pages/review_page.dart';
import 'package:dicoding_restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/utils/internet_connection_helper.dart';
import 'package:dicoding_restaurant_app/utils/style.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final String restaurantId;
  const DetailPage({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isFavorited = false;

  void toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailRestaurantProvider(
        id: widget.restaurantId,
        apiService: ApiService(),
      ),
      child: Scaffold(
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              final restaurant = state.result.restaurant;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag:
                              "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                          child: Image.network(
                            "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.6),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.6),
                                child: IconButton(
                                  onPressed: toggleFavorite,
                                  icon: Icon(
                                    Icons.favorite,
                                    color: _isFavorited
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.verified_user,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                restaurant.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: blackColor,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: primaryColor,
                              ),
                              Text(
                                restaurant.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red.shade500,
                              ),
                              Text(
                                restaurant.city,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Deskripsi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            restaurant.description,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    menuWidget(state),
                    const SizedBox(
                      height: 10,
                    ),
                    reviewWidget(restaurant),
                  ],
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else {
              throw checkInternetConnection();
            }
          },
        ),
      ),
    );
  }

  Padding reviewWidget(Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Ulasan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ReviewPage(
                          restaurantId: restaurant.id,
                        );
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit_note,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ...restaurant.customerReviews.map((e) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(
                        Icons.person_2,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            e.review,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            e.date,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Padding menuWidget(DetailRestaurantProvider state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Menu",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Foods:",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 30,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              reverse: true,
              itemBuilder: (context, index) {
                final menu = state.result.restaurant.menus;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryColor.withOpacity(0.6)),
                  child: Text(
                    menu.foods[index].name,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Drinks:",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 30,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              reverse: true,
              itemBuilder: (context, index) {
                final menu = state.result.restaurant.menus;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryColor.withOpacity(0.6)),
                  child: Text(
                    menu.drinks[index].name,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
