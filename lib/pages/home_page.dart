import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/pages/detail_page.dart';
import 'package:dicoding_restaurant_app/provider/search_restaurant_provider.dart';

import 'package:dicoding_restaurant_app/widgets/custom_sliver_appbar_widget.dart';
import 'package:dicoding_restaurant_app/widgets/error_indicator_widget.dart';

import 'package:dicoding_restaurant_app/widgets/list_restaurant_card_widget.dart';
import 'package:dicoding_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildList(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
          itemCount: state.result.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = state.result.restaurants[index];
            return ListRestaurantCardWidget(
              pictureId: restaurant.pictureId,
              name: restaurant.name,
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
      } else if (state.state == ResultState.noData ||
          state.state == ResultState.error) {
        if (state.message.contains('Failed host lookup')) {
          return const ErrorIndicator(
            errormessage: 'Tidak dapat tersambung dengan internet',
          );
        }

        return const ErrorIndicator(
          errormessage: 'Data tidak ditemukan',
        );
      } else {
        return const Material(child: Text(''));
      }
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, isSrolled) {
        return [
          const CustomSliverAppBar(),
        ];
      },
      body: _buildList(context),
    ));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Resto Finder App'),
        transitionBetweenRoutes: false,
      ),
      child: NestedScrollView(
        headerSliverBuilder: (context, isSrolled) {
          return [
            const CustomSliverAppBar(),
          ];
        },
        body: _buildList(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
