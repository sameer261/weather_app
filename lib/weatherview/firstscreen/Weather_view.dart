import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/searchscreen/location_search_screen_controller.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/appbar/customappbar.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({super.key});

  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(gradient: radialGradientBackground),
        child: Column(
          children: [
            CustomTopBar(),
            SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      weatherController.location.value,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              if (weatherController.weatherInfo.value.isEmpty) {
                return SizedBox();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  weatherController.weatherInfo.value,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
