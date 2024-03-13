import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  final String errormessage;

  const ErrorIndicator({Key? key, required this.errormessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 75),
        Text(
          errormessage,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
