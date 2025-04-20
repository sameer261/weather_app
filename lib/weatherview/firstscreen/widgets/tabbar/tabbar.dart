// custom_tabbar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/tabbar/tabbar_controller.dart';
import 'package:weather_app/weatherview/secondscreen/7days_weather_screen.dart';

class CustomTabBar extends StatelessWidget {
  final TabIndexController tabController = Get.find<TabIndexController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildTab("Today", 0),
                SizedBox(width: 12),
                _buildTab("Tomorrow", 1),
              ],
            ),
            GestureDetector(
              onTap: () async {
                tabController.changeTab(2);
                await Get.to(() => sevendaysWeatherScreen());
                tabController.changeTab(0); // Reset when returning
              },
              child: Row(
                children: [
                  Text(
                    "Next 7 Days",
                    style: TextStyle(
                      color:
                          tabController.selectedIndex.value == 2
                              ? Color(0xFF313341)
                              : Color(0xFFD6996B),
                      fontSize: 8,
                      fontWeight:
                          tabController.selectedIndex.value == 2
                              ? FontWeight.w700
                              : FontWeight.w400,
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
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = tabController.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => tabController.changeTab(index),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Color(0xFF313341) : Color(0xFFD6996B),
          fontSize: 8,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
    );
  }
}
