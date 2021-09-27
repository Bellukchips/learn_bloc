import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/weather/models/models.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherRepository;

part 'weather_state.dart';
part 'weather_cubit.g.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherState());

  final WeatherRepository _weatherRepository;

  ///fetchWeather
  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather =
          Weather.fromRepository(await _weatherRepository.getWeather(city));

      final units = state.temperatureUnits;
      final value = units.isFarenheit
          ? weather.temperature.value.toFarenheit()
          : weather.temperature.value;

      emit(state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(temperature: Temperature(value: value))));
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  ///
  ///Resfersh [Weather]
  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return;

    if (state.weather == Weather.empty) return;
    try {
      final weather = Weather.fromRepository(
          await _weatherRepository.getWeather(state.weather.location));

      final units = state.temperatureUnits;
      final value = units.isFarenheit
          ? weather.temperature.value.toFarenheit()
          : weather.temperature.value;

      emit(state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(temperature: Temperature(value: value))));
    } on Exception {
      emit(state);
    }
  }

  //toggleUnits
  void toggleUnits() {
    final units = state.temperatureUnits.isFarenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    if (!state.status.isSuccess) {
      emit(state.copyWith(temperatureUnits: units));
      return;
    }

    final weather = state.weather;
    if (weather != Weather.empty) {
      final temperature = weather.temperature;
      final value = units.isCelsius
          ? temperature.value.toCelcius()
          : temperature.value.toFarenheit();

      emit(state.copyWith(
          temperatureUnits: units,
          weather: weather.copyWith(temperature: Temperature(value: value))));
    }
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(WeatherState state) => state.toJson();
}

extension on double {
  double toFarenheit() => ((this * 9 / 5) + 32);
  double toCelcius() => ((this - 32) * 5 / 9);
}
