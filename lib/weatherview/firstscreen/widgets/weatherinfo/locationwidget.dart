import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/weatherinfo_controller.dart';

class LocationWidget extends StatelessWidget {
  final WeatherInfoController weatherController = Get.put(
    WeatherInfoController(),
  );

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final String formattedDate = DateFormat('EEE, MMM d').format(now);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Obx(() {
        final parts = weatherController.location.value.split(', ');
        final city = parts.isNotEmpty ? parts[0] : '';
        final state = parts.length > 1 ? parts[1] : '';

        final bool hasCity = city.isNotEmpty;
        final bool hasState = state.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hasCity ? "$city," : "Enter your city",
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 26,
                color: Color(0xff313341),
              ),
            ),
            if (hasState)
              Text(
                state,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  color: Color(0xff313341),
                ),
              ),
            if (!hasCity) // When no city and no state
              Text(
                "Location",
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  color: Color(0xff313341),
                ),
              ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Color(0xff9A938C),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
