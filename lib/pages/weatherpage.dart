import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/model/weathermodel.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherServices('YOUR_API_KEY_GOES_HERE');
  Weather? _weather;

  // fetch weather
  Future_fetchWeather() async {
    // get the current location
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //errors
    catch (e) {
      print(e);
    }
  }

  //animations

  // init state
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
