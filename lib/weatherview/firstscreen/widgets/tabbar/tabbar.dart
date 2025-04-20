import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/tabbar/tabbar_controller.dart';
import 'package:weather_app/weatherview/secondscreen/7days_weather_screen.dart';

class CustomTabBar extends StatelessWidget {
  final TabIndexController tabController = Get.find<TabIndexController>();

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
                  child: Column(
                    children: [
                      Row(
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
                      SizedBox(height: 8),
                      Visibility(
                        visible: false,
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
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // This is where the tab content shows
          Center(
            child: Builder(
              builder: (_) {
                final selectedIndex = tabController.selectedIndex.value;
                if (selectedIndex == 0) {
                  return Text(
                    "Today's forecast will be shown here",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  );
                } else if (selectedIndex == 1) {
                  return Text(
                    "Tomorrow's forecast will be shown here",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
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
