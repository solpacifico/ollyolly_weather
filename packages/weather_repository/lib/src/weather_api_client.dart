// We are going to be hitting two endpoints so our WeatherApiClient needs to expose two public methods:
// getLocationId(String city)
// fetchWeather(int locationId)

import 'dart:convert';
import 'models/models.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  static const host = 'api.openweathermap.org';
  static const lat = '4.60971';
  static const lon = '-74.08175';
  static const key = "80a274c5c9601fa7d4a7e380191f8a37";
  final http.Client httpClient;

  WeatherApiClient({required this.httpClient});



  fetchWeather() async {

    final weatherUrl =Uri(
        scheme: 'https',
        host: host,
        path: '/data/2.5/weather',
        queryParameters: {'lat': lat,'lon': lon, 'appid': key, 'units':'metric'});

    //Uri.https('$baseUrl/data/2.5/weather?lat=$lat&lon=$lon&appid=$key';
    final weatherResponse = await this.httpClient.get(weatherUrl );
    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return Weather.fromJson(weatherJson);
  }
}
