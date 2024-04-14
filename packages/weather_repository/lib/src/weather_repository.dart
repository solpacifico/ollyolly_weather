import 'models/models.dart';
import 'weather_api_client.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({required this.weatherApiClient});

  // as a USER we required City name
  Future<Weather> getWeather() async {

    return await weatherApiClient.fetchWeather();
  }
}
