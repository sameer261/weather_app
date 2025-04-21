import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/tabbar/today_weather_controller.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final double lat;
  final double lon;

  HourlyWeatherWidget({required this.lat, required this.lon}) {
    Get.lazyPut(() => HourlyWeatherController());
    final controller = Get.find<HourlyWeatherController>();
    controller.fetchTodayHourlyWeather(lat, lon);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HourlyWeatherController>();
    return Obx(() {
      if (controller.todayHourlyData.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Text("No hourly data available."),
        );
      }

      return SizedBox(
        height: 105,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.todayHourlyData.length,
          itemBuilder: (context, index) {
            final data = controller.todayHourlyData[index];
            final time = data['time'];
            final temp = data['temp'];
            final icon = data['icon'];

            return Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${time.hour}:00",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Image.network(
                    "https://openweathermap.org/img/wn/$icon@2x.png",
                    width: 40,
                    height: 40,
                  ),

                  Text(
                    "${temp.toStringAsFixed(0)}°C",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
