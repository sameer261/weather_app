// lib/widgets/custom_top_bar.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/searchscreen/location_search_screen.dart';

class CustomTopBar extends StatelessWidget {
  const CustomTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Icon (Search)
            GestureDetector(
              onTap: () {
                Get.to(() => const LocationSearchScreen());
              },
              child: Image.asset(
                'assets/images/search.png',
                width: 24,
                height: 24,
              ),
            ),

            // Center 4 Dots (rounded rectangles)
            Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: customDark,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: customDark,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 17,
                  height: 4,
                  decoration: BoxDecoration(
                    color: customDark,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: customDark,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),

            // Right Icon (Menu / Any Icon)
            Image.asset('assets/images/icon.png', width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}
