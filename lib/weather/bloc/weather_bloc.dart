import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:weather_repository/weather_repository.dart';


part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherInitial()){
    on<GetWeather>(_onRequestWeather);
  }

  @override
  WeatherState get initialState => WeatherInitial();



  // @override
  // Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
  //   if (event is GetWeather) {
  //     yield* _mapGetWeatherToState(event);
  //   }
  // }

  // Stream<WeatherState> _mapGetWeatherToState(GetWeather event) async* {
  //   try {
  //     final weather = await weatherRepository.getWeather(event.location);
  //     yield WeatherLoaded(weather: weather);
  //   } catch (e) {
  //     yield WeatherError();
  //   }
  // }

  Future<void> _onRequestWeather(
      GetWeather event,
      Emitter<WeatherState> emit,
      ) async {

    emit( WeatherLoadInProgress());
      // try {
        final weather = await weatherRepository.getWeather(event.location);
        emit(WeatherLoadSuccess(weather: weather) );
      // } catch (_) {
      //   emit(WeatherError());
      // }

  }


}
class WeatherError extends WeatherState {}