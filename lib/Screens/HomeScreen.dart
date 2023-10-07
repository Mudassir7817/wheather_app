import 'dart:developer';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Models/FiveDaysWeatherModel.dart';
import 'package:weather_app/Models/Wheather_model.dart';
import 'package:weather_app/Screens/5-DayForecast.dart';
import 'package:weather_app/Services/Wheather_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  WeatherModel data = WeatherModel();
  WheatherApi weatherApi = WheatherApi();
  WeatherData? weatherData;
  String selectedCity = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      log('selectedCity:$selectedCity');
      data = await weatherApi.getCurrentWheather(selectedCity);
      weatherData = await weatherApi.getFiveDayWeather();
    } catch (e) {
      log('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
          title: Text(
            selectedCity,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                CityPicker(context);
              },
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: data == null
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            width: mq.width * .85,
                            height: mq.height * .362,
                            child: Image.asset(
                              getWeatherIconPath(weatherData!.entries[0].id),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data?.weather.toString() ?? " ",
                              style: const TextStyle(fontSize: 32),
                            ),
                            const SizedBox(
                              width: 22,
                            ),
                            Text(
                              data?.temp.toString() ?? '',
                              style: const TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 57,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 7,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3))
                              ],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40)),
                              color: const Color.fromARGB(255, 159, 123, 255)),
                          height: mq.height * .37,
                          width: mq.width * 1.0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 26.0, left: 18.0),
                                  child: Text(
                                    'Today',
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    fourDaysForecast(
                                        weatherData!.entries[0].temperature
                                            .toInt(),
                                        weatherData!.entries[0].dateTime
                                            .toString(),
                                        weatherData!.entries[0].id),
                                    fourDaysForecast(
                                        weatherData!.entries[1].temperature
                                            .toInt(),
                                        weatherData!.entries[1].dateTime
                                            .toString(),
                                        weatherData!.entries[1].id),
                                    fourDaysForecast(
                                        weatherData!.entries[2].temperature
                                            .toInt(),
                                        weatherData!.entries[2].dateTime
                                            .toString(),
                                        weatherData!.entries[2].id),
                                    fourDaysForecast(
                                        weatherData!.entries[3].temperature
                                            .toInt(),
                                        weatherData!.entries[3].dateTime
                                            .toString(),
                                        weatherData!.entries[3].id)
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(40, 30)),
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const FiveDayForecastScreen()));
                                    },
                                    child: const Text(
                                      '5-Day Forecast ->',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 159, 123, 255)),
                                    ),
                                  ),
                                )
                              ]),
                        )
                      ],
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Container();
                },
              ));
  }

  Widget fourDaysForecast(int temperature, String time, int weathercode) {
    log('weathercode:$weathercode');
    return Container(
      height: 150,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 205, 186, 255)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$temperature°',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          SizedBox(
              width: 240,
              height: 75,
              child: Image.asset(getWeatherIconPath(weathercode))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$time:00',
                style: const TextStyle(fontSize: 18, color: Colors.white)),
          )
        ],
      ),
    );
  }

  String getWeatherIconPath(int weathercode) {
    switch (weathercode) {
      case 200:
      case 201:
      case 202:
      case 210:
      case 211:
      case 212:
      case 221:
      case 230:
      case 231:
      case 232:
        return 'assets/images/28.png';
      case 300:
      case 301:
      case 302:
      case 310:
      case 311:
      case 312:
      case 313:
      case 314:
      case 321:
        return 'assets/images/8.png';
      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
      case 511:
      case 520:
      case 521:
      case 522:
      case 531:
        return 'assets/images/13.png';
      case 600:
      case 601:
      case 602:
      case 611:
      case 612:
      case 613:
      case 615:
      case 616:
      case 620:
      case 621:
      case 622:
        return 'assets/images/36.png';
      case 800:
        return 'assets/images/26.png';
      case 801:
      case 802:
      case 803:
      case 804:
        return 'assets/images/35.png';
        break;
      default:
        return 'assets/images/35.png';
    }
  }

  void CityPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          title: const Text('Enter City Name'),
          content: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  selectedCity = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 27,
              ),
              SizedBox(
                  width: 250,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('Save')))
            ],
          ),
        );
      },
    );
  }
}
