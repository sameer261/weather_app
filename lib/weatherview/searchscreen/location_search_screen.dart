import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/searchscreen/location_search_screen_controller.dart';

class LocationSearchScreen extends StatelessWidget {
  const LocationSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController locationController = TextEditingController();
    final WeatherController weatherController = Get.put(WeatherController());

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

            // Use current location (optional)
            TextButton.icon(
              onPressed: () {
                // Your current location logic here
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

            const SizedBox(height: 10),

            // Get Weather button
            GestureDetector(
              onTap: () {
                final loc = locationController.text.trim();
                if (loc.isNotEmpty) {
                  weatherController.updateLocation(loc);
                  Get.back();
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFBCA1C), Color(0xFFD6996B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 5),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Get Weather",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
