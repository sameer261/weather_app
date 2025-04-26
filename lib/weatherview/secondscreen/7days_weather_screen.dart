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
            SizedBox(height: 10),
            NormalDayRow(day: 'Thursday', temperature: '21°'),
            NormalDayRow(day: 'Friday', temperature: '20°'),
            NormalDayRow(day: 'Saturday', temperature: '18°'),
          ],
        ),
      ),
    );
  }
}
