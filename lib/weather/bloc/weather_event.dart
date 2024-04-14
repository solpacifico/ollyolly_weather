

part of 'weather_bloc.dart';

abstract class WeatherEvent {}

final class GetWeather extends WeatherEvent {
  final String location;

  GetWeather({required this.location});
}
