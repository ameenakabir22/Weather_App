import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/model/weathermodel.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherServices('63129efc2865e23187009d071fdcb739');
  Weather? _weather;
  // fetch weather
  _fetchWeather() async {
    // Get the current city
    String? cityName = await _weatherService.getCurrentCity();

    if (cityName != null) {
      // Get the weather for the city
      try {
        final weather = await _weatherService.getWeather(cityName);
        // Assign the weather data to your _weather property if needed
        setState(() {
          _weather = weather;
        });
      } catch (error) {
        // Handle any errors that occur during weather retrieval
        print("Error fetching weather: $error");
      }
    } else {
      // Handle the case where cityName is null (e.g., show an error or provide a default city name)
      print("City name is null");
    }
  }

  //weather animation

  // init state
  @override
  void initState() {
    super.initState();
    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
