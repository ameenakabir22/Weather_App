import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/model/weathermodel.dart'; // Import the correct Weather class from the model file

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherServices('YOUR_API_KEY'); // Replace with your API key
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

  // Weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition) {
      case 'Clouds':
      case 'Mist':
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Fog':
        return 'assets/cloud.json';
      case 'Rain':
      case 'Drizzle':
      case 'Shower rain':
        return 'assets/rain.json';
      case 'Thunderstorm':
        return 'assets/thunder.json';
      case 'Clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json'; // Use a default animation if condition is unknown
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
            // City name
            Text(_cityName), // Use the updated _cityName

            // Animations
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition ??
                'Clear')), // Provide a default condition if _weather?.mainCondition is null

            // Temperature
            Text(
                '${_weather?.temperature?.round() ?? 0}ºC'), // Provide a default value if temperature is null

            // Main condition
            Text(_weather?.mainCondition ?? "Condition not available"),
          ],
        ),
      ),
    );
  }
}
