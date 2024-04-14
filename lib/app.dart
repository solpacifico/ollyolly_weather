import 'package:authentication_repository/authentication_repository.dart';
import 'package:ollyolly_weather/login/view/view.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ollyolly_weather/weather/weather.dart';
import 'package:ollyolly_weather/login/login.dart';
import 'package:ollyolly_weather/login/view/login_page.dart';
import 'package:http/http.dart' as http;
import 'authentication/bloc/authentication_bloc.dart';



class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final WeatherRepository _weatherRepository ;


  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _weatherRepository =  WeatherRepository(
        weatherApiClient: WeatherApiClient(
        httpClient: http.Client()));
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
            create:(context) =>_authenticationRepository,)
      ],
      child:MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create:(BuildContext context) => AuthenticationBloc(
                  authenticationRepository: _authenticationRepository),
          ),
          BlocProvider<WeatherBloc>(create: (BuildContext context) => WeatherBloc(
              weatherRepository: _weatherRepository))
        ],
        child: const AppView(),
      )
      );

  }


}



class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  Weather_Page.route(),
                      (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                      (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => LoginPage.route(),
    );
  }
}