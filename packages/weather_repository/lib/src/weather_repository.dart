import 'models/models.dart';
import 'weather_api_client.dart';
import 'package:meta/meta.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({required this.weatherApiClient})
      : assert(weatherApiClient != null);

  // as a USER we required City name
  Future<Weather> getWeather(String city) async {

    return await weatherApiClient.fetchWeather(city);
  }
}
