class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({required this.cityName, required this.mainCondition,required  this.temperature});
}
 
factory Weather.fromJson(Map<String, dynamic> json) {
  if (json.containsKey('name') &&
      json['main'] != null &&
      json['main'].containsKey('temp') &&
      json['weather'] is List && json['weather'].isNotEmpty) {
    final cityName = json['name'];
    final mainData = json['main'];
    final temperature = mainData['temp'].toDouble();
    final weatherList = json['weather'] as List;
    final weatherData = weatherList[0] as Map<String, dynamic>;
      }
}