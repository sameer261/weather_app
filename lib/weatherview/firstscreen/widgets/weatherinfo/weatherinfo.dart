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

      if (iconPath.isEmpty && weatherText.isEmpty) return SizedBox();

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
    });
  }
}
