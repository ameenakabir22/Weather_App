import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weathermodel.dart';

class WeatherServices {
  static const BASE_URL = "https://openweathermap.org/api/data/2.5/weather";
  final String apiKey;

  WeatherServices(this.apiKey);

  Future<Weather?> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
  }

  Future<String?>? getCurrentCity() async {
    // get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }
}
