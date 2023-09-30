import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FiveDayForecastScreen extends StatelessWidget {
  const FiveDayForecastScreen({super.key});

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
                height: mq.height * .3,
                width: mq.width * 1.0,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 159, 123, 255),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45))),
                child: const Stack(
                  children: [
                    Positioned(
                      top: 4,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 40,
                      ),
                    ),
                    Positioned(
                      top: 11,
                      left: 85,
                      child: Text(
                        '5-Day Forecast',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        top: 80,
                        right: 80,
                        child: Text(
                          'Tomorrow',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
