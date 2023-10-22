class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({required this.cityName, required this.mainCondition,required  this.temperature});
}

factory Weather.fromjson(Map<String, dynamic> json){

}