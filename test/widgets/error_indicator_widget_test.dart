import 'package:dicoding_restaurant_app/widgets/error_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ErrorIndicator Widget Test', (WidgetTester tester) async {
    // Build ErrorIndicator
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: ErrorIndicator(
          errormessage: "Error Message",
        ),
      ),
    ));

    // Verify if ErrorIndicator is rendered
    expect(find.text('Error Message'), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);

    // Verify if error message is displayed correctly
    expect(
      tester.widget<Text>(find.byType(Text)).data,
      'Error Message',
    );
  });
}
