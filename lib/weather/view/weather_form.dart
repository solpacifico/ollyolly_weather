import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ollyolly_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:http/http.dart' as http;



class Weather_Form extends StatefulWidget {
  const Weather_Form({super.key});

@override
_WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather_Form> {
  final _weatherBloc = WeatherBloc(
        weatherRepository: WeatherRepository(
            weatherApiClient: WeatherApiClient(
               httpClient: http.Client()
            )
        )
  );




  @override
  Widget build(BuildContext context) {
    _weatherBloc.add(GetWeather());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _weatherBloc.add(GetWeather());
              },
              child: const Text("Refresh"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<WeatherBloc, WeatherState>(
                bloc: _weatherBloc,
                builder: (context, state) {
                  if (state is WeatherLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is WeatherLoadSuccess) {
                    return GradientContainer(
                      color: Colors.blueGrey,                      
                      children: const [],
                      child: RefreshIndicator(
                        onRefresh: (){
                           _weatherBloc.add(
                                GetWeather()

                           );
                           throw '';
                        }, child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: Center(
                              child: Location(location: state.weather.location),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: Center(
                              child: CombinedWeatherTemperature(
                                weather: state.weather,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ),
                    );
                  }
                  if (state is WeatherError) {
                    return const Center(child: Text("Failed to get weather"));
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



