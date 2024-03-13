import 'dart:io';
import 'package:dicoding_restaurant_app/widgets/error_indicator_widget.dart';
import 'package:flutter/material.dart';

Future<Widget> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return const ErrorIndicator(
        errormessage: 'Data tidak ditemukan',
      );
    }
  } on SocketException catch (_) {
    return const ErrorIndicator(
      errormessage: 'Tidak tersambung dengan internet',
    );
  }
  return const ErrorIndicator(
    errormessage: 'Tidak tersambung dengan internet',
  );
}

Widget buildInternetConnectionCheck() {
  return FutureBuilder<Widget>(
    future: checkInternetConnection(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasData) {
        return snapshot.data!;
      } else {
        return Container();
      }
    },
  );
}
