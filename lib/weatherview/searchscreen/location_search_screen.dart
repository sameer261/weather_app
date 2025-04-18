import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/searchscreen/location_search_screen_controller.dart';

class LocationSearchScreen extends StatelessWidget {
  const LocationSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController locationController = TextEditingController();
    final WeatherController weatherController = Get.find<WeatherController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(gradient: radialGradientBackground),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 46),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search Location",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),

            // Input field
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: TextField(
                controller: locationController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    weatherController.searchLocation(value);
                  } else {
                    weatherController.locationSuggestions.clear();
                  }
                },
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Enter city or location",
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.location_on, color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Suggestions List
            Obx(() {
              return Expanded(
                child: ListView.builder(
                  itemCount: weatherController.locationSuggestions.length,
                  itemBuilder: (context, index) {
                    final loc = weatherController.locationSuggestions[index];
                    final cityName = loc['name'] ?? '';
                    final country = loc['country'] ?? '';
                    final state = loc['state'] ?? '';

                    return ListTile(
                      title: Text(
                        "$cityName, ${state.isNotEmpty ? "$state, " : ""}$country",
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        weatherController.updateLocationAndWeather(loc);
                        Get.back(); // Go back to previous screen
                      },
                    );
                  },
                ),
              );
            }),

            const SizedBox(height: 10),

            // Use current location (optional)
            TextButton.icon(
              onPressed: () {
                weatherController.useCurrentLocation();
                Get.back();
              },
              icon: const Icon(Icons.my_location, color: Colors.white),
              label: const Text(
                "Use Current Location",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
