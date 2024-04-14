import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:weather_repository/weather_repository.dart';


part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository})
      : super(WeatherInitial()){
    on<GetWeather>(_onRequestWeather);
  }

  WeatherState get initialState => WeatherInitial();




  // }

  Future<void> _onRequestWeather(
      GetWeather event,
      Emitter<WeatherState> emit,
      ) async {

    emit( WeatherLoadInProgress());
      try {
        final weather = await weatherRepository.getWeather();
        emit(WeatherLoadSuccess(weather: weather) );
      } catch (_) {
        emit(WeatherError());
      }

  }


}
class WeatherError extends WeatherState {}