import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/Models/FiveDaysWeatherModel.dart';
import 'package:weather_app/Services/Wheather_api.dart';

class FiveDayForecastScreen extends StatefulWidget {
  const FiveDayForecastScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FiveDayForecastScreen> createState() => _FiveDayForecastScreenState();
}

class _FiveDayForecastScreenState extends State<FiveDayForecastScreen> {
  WeatherData? weatherData;
  WheatherApi api = WheatherApi();

  @override
  void initState() {
    super.initState();
    setState(() {
      _getData();
    });
  }

  Future<void> _getData() async {
    weatherData = await api.getFiveDayWeather();
    log(weatherData!.entries[0].temperature.toString());
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 159, 123, 255),
    ));
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .038,
            child: Container(
              height: mq.height * .25,
              width: mq.width * 1.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 5,
                      blurRadius: 0,
                      offset: const Offset(1, 8),
                    )
                  ],
                  color: const Color.fromARGB(255, 159, 123, 255),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45))),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Positioned(
                    top: 11,
                    left: 85,
                    child: Text(
                      '5-Day Forecast',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Positioned(
                      top: 70,
                      right: 50,
                      child: Text(
                        'Tomorrow',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )),
                  Positioned(
                      top: 100,
                      right: 90,
                      child: Text(
                        '${weatherData!.entries[0].temperature.toStringAsFixed(0)}/',
                        style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                  const Positioned(
                      top: 110,
                      right: 55,
                      child: Text(
                        '20°',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                  const Positioned(
                      top: 140,
                      right: 80,
                      child: Text(
                        'Light rain',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
          ),
          Positioned(
              top: 110,
              left: 10,
              child: SizedBox(
                  width: 220, child: Image.asset('assets/images/8.png'))),
          Positioned(
              left: 20,
              top: 330,
              child: listOfFourDaysForecast(
                  weatherData!.entries[1].temperature.toStringAsFixed(0),
                  weatherData!.entries[1].dateTime.toString())),
          Positioned(
              left: 20,
              top: 440,
              child: listOfFourDaysForecast(
                  weatherData!.entries[2].temperature.toStringAsFixed(0),
                  weatherData!.entries[2].dateTime.toString())),
          Positioned(
              left: 20,
              top: 550,
              child: listOfFourDaysForecast(
                  weatherData!.entries[3].temperature.toStringAsFixed(0),
                  weatherData!.entries[3].dateTime.toString())),
          Positioned(
              left: 20,
              top: 660,
              child: listOfFourDaysForecast(
                  weatherData!.entries[4].temperature.toStringAsFixed(0),
                  weatherData!.entries[4].dateTime.toString())),
        ],
      ),
    );
  }

  Widget listOfFourDaysForecast(String temp, String time) {
    return Container(
      width: 320,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 159, 123, 255),
            Color.fromARGB(255, 225, 216, 252),
          ],
          stops: [0, 4.0],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0, left: 2.0, bottom: 0),
                child: Text(
                  'Friday',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 24.0, bottom: 0),
                child: Text(
                  time,
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            '$temp°',
            style: const TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 92, 34, 252),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(width: 80, child: Image.asset('assets/images/8.png'))
        ],
      ),
    );
  }
}
