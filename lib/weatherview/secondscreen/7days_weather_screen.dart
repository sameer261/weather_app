import 'package:flutter/material.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/secondscreen/widgets/alldays.dart';
import 'package:weather_app/weatherview/secondscreen/widgets/header.dart';
import 'package:weather_app/weatherview/secondscreen/widgets/tomorrowcard.dart';

class sevendaysWeatherScreen extends StatelessWidget {
  const sevendaysWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: radialGradientBackground),
        child: Column(
          children: [
            Header(),
            SizedBox(height: 10),
            RowActive(),
            SizedBox(height: 30),
            NormalDayRow(
              day: 'Thursday',
              temperature: '38°',
              iconPath: 'assets/images/sun.svg',
            ),
            NormalDayRow(
              day: 'Friday',
              temperature: '37°',
              iconPath: 'assets/images/sun.svg',
            ),
            NormalDayRow(
              day: 'Saturday',
              temperature: '39°',
              iconPath: 'assets/images/sun.svg',
            ),
            NormalDayRow(
              day: 'Sunday',
              temperature: '40°',
              iconPath: 'assets/images/sun.svg',
            ),
            NormalDayRow(
              day: 'Monday',
              temperature: '39°',
              iconPath: 'assets/images/sun.svg',
            ),
            NormalDayRow(
              day: 'Tuesday',
              temperature: '38°',
              iconPath: 'assets/images/sun.svg',
            ),
          ],
        ),
      ),
    );
  }
}
