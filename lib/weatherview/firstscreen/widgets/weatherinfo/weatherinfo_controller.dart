import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart'; // Import Geolocator

import 'package:weather_app/weatherview/firstscreen/widgets/tabbar/today_weather_controller.dart';

class WeatherInfoController extends GetxController {
  RxString location = ''.obs;
  RxString weatherInfo = ''.obs;
  RxString weatherIconPath = ''.obs;
  RxBool isWeatherLoading = false.obs;

  RxDouble humidity = 0.0.obs;
  RxDouble windSpeed = 0.0.obs;
  RxDouble rainfall = 0.0.obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  final String apiKey = '6fbcdad70318ecd7f0a756be6ff23b21';

  Future<void> getCurrentLocationAndWeather() async {
    // Request permission for location
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // Get current position (latitude and longitude)
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Update latitude and longitude
      this.latitude.value = position.latitude;
      this.longitude.value = position.longitude;

      // Fetch city and state from lat and lon (you need a reverse geocoding API or method for this)
      String city = await getCityFromCoordinates(
        position.latitude,
        position.longitude,
      );
      String state = await getStateFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Update the location information
      updateLocation(city, state);

      // Fetch weather based on current location
      await getWeather("", position.latitude, position.longitude);
    } else {
      // Handle the case where permission is denied
      print("Location permission denied");
    }
  }

  Future<String> getCityFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    // Use a reverse geocoding service to get the city from latitude and longitude
    // Here, you can use a service like OpenWeather, Google Maps, etc.
    // For simplicity, let's assume it's just a placeholder:
    return "Current"; // Replace with actual reverse geocoding logic
  }

  Future<String> getStateFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    // Similar to getCityFromCoordinates, this will use reverse geocoding to fetch state
    return "Location"; // Replace with actual reverse geocoding logic
  }

  // Function to fetch weather data based on latitude and longitude
  Future<void> getWeather(String city, double lat, double lon) async {
    isWeatherLoading.value = true;
    final hourlyController = Get.find<HourlyWeatherController>();
    await hourlyController.fetchTodayHourlyWeather(lat, lon);
    this.latitude.value = lat;
    this.longitude.value = lon;

    final currentUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    try {
      final currentResponse = await http.get(Uri.parse(currentUrl));
      if (currentResponse.statusCode == 200) {
        final weatherData = json.decode(currentResponse.body);
        final description = weatherData['weather'][0]['description'];
        final iconPath = getIconForDescription(description);

        double temp = weatherData['main']['temp'].toDouble();
        int roundedTemp = temp.round();

        humidity.value = weatherData['main']['humidity'].toDouble();
        windSpeed.value = weatherData['wind']['speed'].toDouble();
        rainfall.value =
            weatherData['rain'] != null
                ? weatherData['rain']['1h'] ?? 0.0
                : 0.0;

        weatherInfo.value = '$roundedTemp°C\n$description';
        weatherIconPath.value = iconPath;
      } else {
        weatherInfo.value = 'Failed to load weather data';
        weatherIconPath.value = '';
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      weatherInfo.value = 'Error fetching weather data';
      weatherIconPath.value = '';
    } finally {
      isWeatherLoading.value = false;
    }
  }

  // Function to get the appropriate weather icon for the description
  String getIconForDescription(String description) {
    description = description.toLowerCase();

    if (description.contains('clear')) {
      return 'assets/images/sun_cloud.svg';
    } else if (description.contains('few clouds')) {
      return 'assets/images/sun_cloud.svg';
    } else if (description.contains('scattered clouds') ||
        description.contains('broken clouds') ||
        description.contains('clouds')) {
      return 'assets/images/cloud.svg';
    } else if (description.contains('shower rain') ||
        description.contains('light rain') ||
        description.contains('moderate rain') ||
        description.contains('heavy rain')) {
      return 'assets/images/cloud_rain.svg';
    } else if (description.contains('rain') && description.contains('sun')) {
      return 'assets/images/cloud_with_sun_rain.svg';
    } else if (description.contains('overcast clouds')) {
      return 'assets/images/half_sun_cloud.svg';
    } else {
      return 'assets/images/cloud.svg';
    }
  }

  // Function to update the location based on city and state
  void updateLocation(String city, String state) {
    location.value = state.isNotEmpty ? '$city, $state' : city;
  }
}
