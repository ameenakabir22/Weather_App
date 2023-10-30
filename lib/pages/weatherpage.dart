import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/model/weathermodel.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherServices('63129efc2865e23187009d071fdcb739');
  Weather? _weather;
  String _cityName = "Loading city ..."; // Initialize with a default value

  _fetchWeather() async {
    String? cityName = await _weatherService.getCurrentCity();

    if (cityName != null) {
      setState(() {
        _cityName = cityName; // Update the city name
      });

      try {
        final weather = await _weatherService.getWeather(cityName);
        setState(() {
          _weather = weather;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_cityName), // Use the updated _cityName

            // animations
            Lottie.asset('assets/sunny.json'),

            // temperature
            Text('${_weather?.temperature.round()}ºC')
          ],
        ),
      ),
    );
  }
}
