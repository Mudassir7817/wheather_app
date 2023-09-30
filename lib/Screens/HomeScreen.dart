import 'package:flutter/material.dart';
import 'package:weather_app/Screens/5-DayForecast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
        title: const Text(
          'Yangon, Myanmar',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
                width: mq.width * .85,
                child: Image.asset('assets/images/8.png')),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Drizzle 32/24',
            style: TextStyle(fontSize: 32),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(top: 26.0, left: 18.0),
                child: Text(
                  'Today',
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  fourDaysForecast(30, 12, 'imagePath'),
                  fourDaysForecast(30, 12, 'imagePath'),
                  fourDaysForecast(30, 12, 'imagePath'),
                  fourDaysForecast(30, 12, 'imagePath')
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(40, 30)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FiveDayForecastScreen()));
                  },
                  child: const Text(
                    '5-Day Forecast ->',
                    style: TextStyle(color: Color.fromARGB(255, 159, 123, 255)),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget fourDaysForecast(int temperature, int time, String imagepath) {
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
              temperature.toString(),
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Image.asset('assets/images/8.png'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$time:00',
                style: const TextStyle(fontSize: 18, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
