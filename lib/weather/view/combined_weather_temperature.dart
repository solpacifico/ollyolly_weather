import 'package:flutter/material.dart';
import 'package:ollyolly_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart' as model;



class CombinedWeatherTemperature extends StatelessWidget {
  final model.Weather weather;

  const CombinedWeatherTemperature({super.key, 
    required this.weather
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: WeatherConditions(condition: weather.image),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                   Temperature(
                    temperature: weather.temp,
                    high: weather.temp_max,
                    low: weather.temp_min,
                  )
              ),
          ],
        ),
        Center(
          child: Text(
            weather.main,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
          const Padding(
          padding: EdgeInsets.all(20.0),
          ),
          Center(
            child: Text(
              'Humidity: ${weather.humidity} % ',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
          ),
        const Padding(
          padding: EdgeInsets.all(20.0),
        ),
        Center(
          child: Text(
            'Wind Speed: ${weather.wind_speed} % ',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),

      ],
    );
  }
}