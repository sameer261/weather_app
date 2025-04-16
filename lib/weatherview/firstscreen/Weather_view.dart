import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/appbar/customappbar.dart';
import 'package:weather_app/weatherview/searchscreen/location_search_screen_controller.dart';

// ignore: camel_case_types
class firstscreen extends StatelessWidget {
  firstscreen({super.key});

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
                        fontWeight: FontWeight.w500, // Simulated bold
                        fontSize: 20, // Custom size
                      ),
                    ),
                  ),
                ],
              ),
            ), // This keeps the gradient visible in the remaining area
          ],
        ),
      ),
    );
  }
}
