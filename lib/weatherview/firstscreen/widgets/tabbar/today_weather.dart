import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/tabbar/today_weather_controller.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final double lat;
  final double lon;

  HourlyWeatherWidget({super.key, required this.lat, required this.lon}) {
    Get.lazyPut(() => HourlyWeatherController());
    final controller = Get.find<HourlyWeatherController>();
    controller.fetchTodayHourlyWeather(lat, lon);
  }
  String getIconPathFromDescription(
    String description,
    String iconCode,
    DateTime time,
  ) {
    description = description.toLowerCase();

    // Karachi ya user ke location ka local time assume karo yahan
    bool isNightTime = time.hour < 6 || time.hour >= 20; // 8pm se 6am raat

    if (description.contains("clear")) {
      return isNightTime ? 'assets/images/moon.svg' : 'assets/images/sun.svg';
    }

    if (description.contains("cloud") && description.contains("sun")) {
      return isNightTime
          ? 'assets/images/moon_cloud.svg'
          : 'assets/images/sun_cloud.svg';
    }

    if (description.contains("cloud") && description.contains("rain")) {
      return 'assets/images/cloud_with_sun_rain.svg';
    }

    if (description.contains("cloud")) {
      return isNightTime
          ? 'assets/images/moon_cloud.svg'
          : 'assets/images/cloud.svg';
    }

    if (description.contains("rain")) {
      return 'assets/images/cloud_rain.svg';
    }

    if (description.contains("thunderstorm")) {
      return 'assets/images/cloud_with_sun_rain.svg';
    }

    if (description.contains("mist") || description.contains("fog")) {
      return isNightTime
          ? 'assets/images/moon_cloud.svg'
          : 'assets/images/cloud.svg';
    }

    return isNightTime
        ? 'assets/images/moon_cloud.svg'
        : 'assets/images/cloud.svg'; // fallback
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HourlyWeatherController>();
    return Obx(() {
      if (controller.todayHourlyData.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: Text("No hourly data available.")),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 105,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.todayHourlyData.length,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemBuilder: (context, index) {
              final data = controller.todayHourlyData[index];
              final time = data['time'];
              final temp = data['temp'];
              final icon = data['icon'] ?? ''; // Ensure icon is not null
              final description =
                  data['description'] ?? ''; // Ensure description is not null
              final assetPath = getIconPathFromDescription(
                description,
                icon,
                time,
              );

              return Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Container(
                  width: 40,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${time.hour.toString().padLeft(2, '0')}:00",
                        style: TextStyle(color: Colors.black, fontSize: 7),
                      ),
                      SvgPicture.asset(assetPath, width: 24, height: 24),
                      Text(
                        "${temp.toStringAsFixed(0)}°C",
                        style: TextStyle(color: Colors.black, fontSize: 7),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
