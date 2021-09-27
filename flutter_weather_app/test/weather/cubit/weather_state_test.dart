import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/weather/weather.dart';

void main() {
  group('WeatherStatusX', () {
    test('returns correct values for WetherStatus.initial', () {
      const status = WeatherStatus.initial;
      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });
    test('returns correct values for WetherStatus.loading', () {
      const status = WeatherStatus.loading;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });
    test('returns correct values for WetherStatus.success', () {
      const status = WeatherStatus.success;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isFailure, isFalse);
    });
    test('returns correct values for WetherStatus.failure', () {
      const status = WeatherStatus.failure;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isTrue);
    });
  });
}
