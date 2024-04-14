
import 'package:flutter/material.dart';
import 'package:ollyolly_weather/weather/view/view.dart';



class Weather_Page extends StatelessWidget {
  const Weather_Page({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Weather_Page());
  }

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Weather',
      //theme: themeState.theme,
      home:Weather_Form(),
      );
    }
}
