import 'package:flutter/material.dart';
import 'package:ollyolly_weather/weather/weather.dart';


class Temperature extends StatelessWidget {
  final double temperature;
  final double low;
  final double high;


  Temperature({

    required this.temperature,
    required this.low,
    required this.high,

  }) ;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Text(
            '${temperature}°',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              'max: ${high}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
            Text(
              'max: ${low}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }




}
