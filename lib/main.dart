import 'package:flutter/material.dart';
import 'package:weather_app/Screens/5-DayForecast.dart';
import 'package:weather_app/Screens/HomeScreen.dart';
import 'package:weather_app/Screens/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
