import 'package:dicoding_restaurant_app/data/models/restaurants.dart';
import 'package:dicoding_restaurant_app/utils/style.dart';

import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;
  const DetailPage({
    Key? key,
    required this.restaurant,
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: widget.restaurant.pictureId,
                child: Image.network(
                  widget.restaurant.pictureId,
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
                          color: _isFavorited ? Colors.red : Colors.white,
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
          _ContentWidget(widget: widget),
          const Divider(
            thickness: 1,
          ),
          _DescriptionWidget(widget: widget),
          const SizedBox(
            height: 10,
          ),
          Padding(
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
                    itemCount: widget.restaurant.menus.foods.length,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    reverse: true,
                    itemBuilder: (context, index) {
                      final menu = widget.restaurant.menus;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
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
                    itemCount: widget.restaurant.menus.drinks.length,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    reverse: true,
                    itemBuilder: (context, index) {
                      final menu = widget.restaurant.menus;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
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
          ),
        ],
      ),
    ));
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    required this.widget,
  });

  final DetailPage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            widget.restaurant.description,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    required this.widget,
  });

  final DetailPage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                widget.restaurant.name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                widget.restaurant.rating.toString(),
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
                widget.restaurant.city,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
