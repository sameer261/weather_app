import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/tabbar/tabbar_controller.dart';
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

          SizedBox(height: 16),

          // Tab content
          Builder(
            builder: (_) {
              final selectedIndex = tabController.selectedIndex.value;
              if (selectedIndex == 0) {
                return Text('no');
                // Obx(() {
                //   final hourlyData = weatherController.hourlyWeatherData;

                //   if (weatherController.isWeatherLoading.value) {
                //     return Center(child: CircularProgressIndicator());
                //   }

                //   if (hourlyData.isEmpty) {
                //     return Center(
                //       child: Padding(
                //         padding: const EdgeInsets.only(top: 16.0),
                //         child: Text(
                //           "No hourly forecast data available",
                //           style: TextStyle(fontSize: 14),
                //         ),
                //       ),
                //     );
                //   }

                //   return SizedBox(
                //     height: 100,
                //     child: ListView.separated(
                //       scrollDirection: Axis.horizontal,
                //       padding: const EdgeInsets.symmetric(horizontal: 16),
                //       itemCount: hourlyData.length,
                //       separatorBuilder: (_, __) => SizedBox(width: 12),
                //       itemBuilder: (_, index) {
                //         final item = hourlyData[index];
                //         return Container(
                //           width: 70,
                //           padding: EdgeInsets.all(8),
                //           decoration: BoxDecoration(
                //             color: Colors.white.withOpacity(0.1),
                //             borderRadius: BorderRadius.circular(12),
                //           ),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text(
                //                 item['time'],
                //                 style: TextStyle(
                //                   fontSize: 10,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //               SizedBox(height: 4),
                //               Text(
                //                 "${item['temp']}°C",
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //               SizedBox(height: 4),
                //               Text(
                //                 item['description'],
                //                 style: TextStyle(
                //                   fontSize: 10,
                //                   color: Colors.white70,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         );
                //       },
                //     ),
                //   );
                // });
              } else if (selectedIndex == 1) {
                return Center(
                  child: Text(
                    "Tomorrow's forecast will be shown here",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return SizedBox.shrink(); // 7 days screen tab
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
