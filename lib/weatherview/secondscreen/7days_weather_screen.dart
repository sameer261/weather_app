import 'package:flutter/material.dart';
import 'package:weather_app/utils/color.dart';

class sevendaysWeatherScreen extends StatelessWidget {
  const sevendaysWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: radialGradientBackground),
      ),
    );
  }
}
