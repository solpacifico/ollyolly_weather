import 'package:equatable/equatable.dart';

enum WeatherCondition {
  // https://www.metaweather.com/api/   (taking icons)

  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown,
}

class Weather extends Equatable {
  final String main;
  final double temp_min;
  final double temp;
  final double temp_max;
  final double humidity;
  final String location; //6252230735822848
  final double wind_speed;



  const Weather(
      {required this.main,
      required this.temp_min,
      required this.temp,
      required this.temp_max,
      required this.humidity,
      required this.location,
      required this.wind_speed
      });

  @override
  List<Object> get props => [
        main,
        temp_min,
        temp,
        temp_max,
        humidity,
        location,
        wind_speed
      ];

  static Weather fromJson(dynamic json) {
    final condition = json['weather'][0];
    final weatherData = json['main'];
    final location = json['name'];
    final wind = json['wind'];
    return Weather(
      main: condition['main'], //icon
      temp_min: weatherData['temp_min']  as double,
      temp: weatherData['temp'] as double,
      temp_max:weatherData['temp_max'] as double,
      humidity:weatherData['humidity'] as double,
      location:location,
      wind_speed:wind['speed'] as double,

    );
  }


}
