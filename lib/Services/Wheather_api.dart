import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather_app/Models/FiveDaysWeatherModel.dart';
import 'package:weather_app/Models/Wheather_model.dart';

class WheatherApi {
  String cityname = '';
  Future<WeatherModel> getCurrentWheather(String city) async {
    cityname = city;
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=3f5eaf965d82435ad91cded2dec5862d&units=metric");
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    return WeatherModel.fromJson(body);
  }

  Future<WeatherData> getFiveDayWeather() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityname&appid=3f5eaf965d82435ad91cded2dec5862d');
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    return WeatherData.fromJson(body);
  }
}
