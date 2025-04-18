import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTopBar(),
            SizedBox(height: 22),

            // Location City + State
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Obx(() {
                final parts = weatherController.location.value.split(', ');
                final city = parts.isNotEmpty ? parts[0] : '';
                final state = parts.length > 1 ? parts[1] : '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city.isNotEmpty ? "$city," : '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Color(0xff313341),
                      ),
                    ),
                    if (state.isNotEmpty)
                      Text(
                        state,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Color(0xff313341),
                        ),
                      ),
                  ],
                );
              }),
            ),

            SizedBox(height: 20),

            // Weather Icon and Info in a Row
            Obx(() {
              final iconPath = weatherController.weatherIconPath.value;
              final weatherText = weatherController.weatherInfo.value;

              if (iconPath.isEmpty && weatherText.isEmpty) {
                return SizedBox();
              }

              final parts = weatherText.split('\n');
              final temp = parts[0].replaceAll('°C', '').trim();
              final description = parts.length > 1 ? parts[1] : '';

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (iconPath.isNotEmpty)
                      SvgPicture.asset(iconPath, width: 120, height: 120),
                    SizedBox(width: 15),
                    if (weatherText.isNotEmpty)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Temperature + °C
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  temp,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 46,
                                    color: customDark,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    '°C',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: customDark,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Weather Description
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text(
                                description,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: customDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
