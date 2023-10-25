import 'package:geocoding/geocoding.dart';
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
    // fetch current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // convert the location into a list placemark of objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // extract the city name from the first placemark
    String? city = placemarks[0].locality;
    return city ?? "";
  }
}