import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ollyolly_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:http/http.dart' as http;


import 'dart:async';

class Weather_Form extends StatefulWidget {
@override
_WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather_Form> {
  final _locationController = TextEditingController();
  final _weatherBloc = WeatherBloc(
        weatherRepository: WeatherRepository(
            weatherApiClient: WeatherApiClient(
               httpClient: http.Client()
            )
        )
  );




  @override
  Widget build(BuildContext context) {
    _weatherBloc.add(GetWeather(location: "Chicago"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: "Enter location",
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _weatherBloc.add(GetWeather(location: _locationController.text));
              },
              child: Text("Get Weather"),
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<WeatherBloc, WeatherState>(
                bloc: _weatherBloc,
                builder: (context, state) {
                  if (state is WeatherLoadInProgress) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is WeatherLoadSuccess) {
                    return Column(
                      children: [
                        Text("Temperature: ${state.weather.temp}"),
                        Text("Humidity: ${state.weather.humidity}"),
                        Text("Wind Speed: ${state.weather.wind_speed}"),
                      ],
                    );
                  }
                  if (state is WeatherError) {
                    return Center(child: Text("Failed to get weather"));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}



