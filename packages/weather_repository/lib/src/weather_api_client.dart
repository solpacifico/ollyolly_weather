// We are going to be hitting two endpoints so our WeatherApiClient needs to expose two public methods:
// getLocationId(String city)
// fetchWeather(int locationId)

import 'dart:async';
import 'dart:convert';
import 'models/models.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  WeatherApiClient({required this.httpClient}) : assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponse = await this.httpClient.get(locationUrl as Uri);
    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId/';
    final weatherResponse = await this.httpClient.get(weatherUrl as Uri);
    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return Weather.fromJson(weatherJson);
  }
}
