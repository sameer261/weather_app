import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/tabbar/tabbar_controller.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/tabbar/today_weather.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/weatherinfo_controller.dart';
import 'package:weather_app/weatherview/secondscreen/7days_weather_screen.dart';

class CustomTabBar extends StatelessWidget {
  final TabIndexController tabController = Get.find<TabIndexController>();
  final WeatherInfoController weatherController =
      Get.find<WeatherInfoController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [_buildTab("Today", 0)]),
                GestureDetector(
                  onTap: () async {
                    tabController.changeTab(2);
                    await Get.to(() => sevendaysWeatherScreen());
                    tabController.changeTab(0); // Reset tab to Today
                  },
                  child: Row(
                    children: [
                      Text(
                        "Next 7 Days",
                        style: TextStyle(
                          color: Color(0xFFD6996B),
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: Color(0xFFD5986A),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 5),

          // Tab content
          Builder(
            builder: (_) {
              final selectedIndex = tabController.selectedIndex.value;
              if (selectedIndex == 0) {
                return HourlyWeatherWidget(
                  lat: weatherController.latitude.value,
                  lon: weatherController.longitude.value,
                );
              } else {
                return SizedBox.shrink(); // Just in case
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = tabController.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => tabController.changeTab(index),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Color(0xFF313341) : Color(0xFFD6996B),
              fontSize: 8,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
          SizedBox(height: 8),
          Visibility(
            visible: isSelected,
            child: Container(
              width: 10,
              height: 3,
              decoration: BoxDecoration(
                color: Color(0xFF313341),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
