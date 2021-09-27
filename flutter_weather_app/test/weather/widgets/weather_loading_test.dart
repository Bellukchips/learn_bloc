import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/weather/weather.dart';

void main() {
  group('WeatherLoading', () {
    testWidgets('renders correct text and icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WeatherLoading(),
          ),
        ),
      );
      expect(find.text('Loading Weather'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('⛅'), findsOneWidget);
    });
  });
}
