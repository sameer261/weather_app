// weather_info_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/weatherinfo_controller.dart';

class WeatherInfoWidget extends StatelessWidget {
  final WeatherInfoController weatherController = Get.put(
    WeatherInfoController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final iconPath = weatherController.weatherIconPath.value;
      final weatherText = weatherController.weatherInfo.value;

      // Check if weather data is available
      final bool hasData = iconPath.isNotEmpty && weatherText.isNotEmpty;

      // If no data, use default values
      final String displayIcon = hasData ? iconPath : 'assets/images/cloud.svg';
      final String displayTemp =
          hasData
              ? weatherText.split('\n')[0].replaceAll('°C', '').trim()
              : '-';
      final String displayDescription =
          hasData && weatherText.split('\n').length > 1
              ? weatherText.split('\n')[1]
              : 'haze';

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(displayIcon, width: 120, height: 120),
            SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayTemp,
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
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      displayDescription,
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
    });
  }
}
