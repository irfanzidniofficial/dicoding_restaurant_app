import 'package:dicoding_restaurant_app/data/models/detail_restaurant.dart';

import 'package:flutter_test/flutter_test.dart';

var dummies = {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
    "city": "Medan",
    "address": "Jln. Pandeglang no 19",
    "pictureId": "14",
    "categories": [
      {"name": "Italia"},
      {"name": "Modern"}
    ],
    "menus": {
      "foods": [
        {"name": "Paket rosemary"},
        {"name": "Toastie salmon"},
        {"name": "Bebek crepes"},
        {"name": "Salad lengkeng"}
      ],
      "drinks": [
        {"name": "Es krim"},
        {"name": "Sirup"},
        {"name": "Jus apel"},
        {"name": "Jus jeruk"},
        {"name": "Coklat panas"},
        {"name": "Air"},
        {"name": "Es kopi"},
        {"name": "Jus alpukat"},
        {"name": "Jus mangga"},
        {"name": "Teh manis"},
        {"name": "Kopi espresso"},
        {"name": "Minuman soda"},
        {"name": "Jus tomat"}
      ]
    },
    "rating": 4.2,
    "customerReviews": [
      {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      },
      {"name": "Abi", "review": "test", "date": "16 Maret 2024"},
      {"name": "Abi", "review": "test", "date": "16 Maret 2024"},
      {"name": "Abi", "review": "test", "date": "16 Maret 2024"},
      {"name": "Abi", "review": "test", "date": "16 Maret 2024"},
      {"name": "Abi", "review": "test", "date": "16 Maret 2024"},
      {"name": "Abi", "review": "test", "date": "16 Maret 2024"},
      {"name": "Abi", "review": "test", "date": "16 Maret 2024"},
      {"name": "Abi", "review": "test", "date": "16 Maret 2024"},
      {"name": "Abi", "review": "test", "date": "16 Maret 2024"},
      {"name": "Abu", "review": "Hayang jajan", "date": "16 Maret 2024"},
      {"name": "Abi", "review": "Huyung jujun", "date": "16 Maret 2024"},
      {
        "name": "Bryant",
        "review": "Restoran ini cocok segala kalangan",
        "date": "16 Maret 2024"
      }
    ]
  }
};

void main() {
  test("Test From Map Detail Restaurant Model", () async {
    var result = DetailRestaurantResult.fromMap(dummies).error;

    expect(result, false);
  });
}
