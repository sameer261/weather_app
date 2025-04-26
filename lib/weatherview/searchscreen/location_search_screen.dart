import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/weatherinfo_controller.dart';
import 'package:weather_app/weatherview/searchscreen/location_search_screen_controller.dart';

class LocationSearchScreen extends StatelessWidget {
  const LocationSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController locationController = TextEditingController();
    final LocationSearchScreenController locationControllerGet = Get.put(
      LocationSearchScreenController(),
    );
    final WeatherInfoController weatherController =
        Get.find<WeatherInfoController>();

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
                    locationControllerGet.searchLocation(value);
                  } else {
                    locationControllerGet.locationSuggestions.clear();
                  }
                },
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: const InputDecoration(
                  hintText: "Enter city or location",
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.location_on, color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Use current location button
            TextButton.icon(
              onPressed: () async {
                await weatherController.getCurrentLocationAndWeather();
                Get.back();
              },
              icon: const Icon(Icons.my_location, color: Colors.white),
              label: Text(
                'Current location',
                style: const TextStyle(color: Colors.white),
              ),

              style: TextButton.styleFrom(foregroundColor: Colors.white),
            ),

            const SizedBox(height: 10),

            // Suggestions or loading
            Obx(() {
              if (weatherController.isWeatherLoading.value) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: locationControllerGet.locationSuggestions.length,
                  itemBuilder: (context, index) {
                    final loc =
                        locationControllerGet.locationSuggestions[index];
                    final cityName = loc['name'] ?? '';
                    final state = loc['state'] ?? '';
                    final displayName =
                        state.isNotEmpty ? "$cityName, $state" : cityName;

                    return ListTile(
                      title: Text(
                        displayName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () async {
                        weatherController.isWeatherLoading.value = true;
                        locationControllerGet.updateLocationAndWeather(loc);

                        // Wait for weather loading to finish then go back
                        ever(weatherController.isWeatherLoading, (loading) {
                          if (loading == false) {
                            Get.back();
                          }
                        });
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
