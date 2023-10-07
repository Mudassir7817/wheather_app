import 'dart:developer';

import 'package:intl/intl.dart';

class WeatherData {
  final List<WeatherEntry> entries;

  WeatherData({required this.entries});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['list'];
    final entries = list
        .map((entry) => WeatherEntry.fromJson(entry))
        .take(5) // Limit to 5 days
        .toList();
    return WeatherData(entries: entries);
  }
}

class WeatherEntry {
  final String dateTime;
  final double temperature;
  final int id;

  WeatherEntry({
    required this.dateTime,
    required this.temperature,
    required this.id,
  });

  factory WeatherEntry.fromJson(Map<String, dynamic> json) {
    final double temperature = (json['main']['temp'] - 273.15)
        .toDouble(); // Convert temperature from Kelvin to Celsius
    final String dtTxt = json['dt_txt'];
    final int id = json['weather'][0]['id'];

    final int hour = DateTime.parse(dtTxt).hour;
    log(hour.toString());
    log(dtTxt);

    return WeatherEntry(
      dateTime: hour.toString(),
      temperature: temperature,
      id: id,
    );
  }
}
