import 'package:flutter/material.dart';

class WeatherConditions extends StatelessWidget {
  final String condition;

  const WeatherConditions({super.key,  required this.condition});

  @override
  Widget build(BuildContext context) => _mapConditionToImage(condition);

  Image _mapConditionToImage(String condition) {
    Image image;
    image = Image.network('https://openweathermap.org/img/wn/$condition@2x.png');

    return image;
  }
}
