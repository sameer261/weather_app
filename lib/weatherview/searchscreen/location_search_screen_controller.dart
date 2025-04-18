import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherController extends GetxController {
  RxString location = ''.obs;
  RxString weatherInfo = ''.obs;
  RxString weatherIconPath = ''.obs;
  RxList<Map<String, dynamic>> locationSuggestions =
      <Map<String, dynamic>>[].obs;

  final String apiKey = '6fbcdad70318ecd7f0a756be6ff23b21';

  // Search for city suggestions
  Future<void> searchLocation(String locationQuery) async {
    final url =
        'http://api.openweathermap.org/geo/1.0/direct?q=$locationQuery&limit=5&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        locationSuggestions.value =
            data.isNotEmpty ? List<Map<String, dynamic>>.from(data) : [];
      } else {
        locationSuggestions.clear();
      }
    } catch (e) {
      print('Error: $e');
      locationSuggestions.clear();
    }
  }

  // Fetch weather details for location
  Future<void> getWeather(String city, double lat, double lon) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body);
        final description = weatherData['weather'][0]['description'];
        final iconPath = getIconForDescription(description);

        // Get the temperature and round it
        double temp = weatherData['main']['temp'].toDouble();
        int roundedTemp =
            temp.round(); // Round the temperature to the nearest integer

        weatherInfo.value = '$roundedTemp°C\n$description\n';

        weatherIconPath.value = iconPath;
      } else {
        weatherInfo.value = 'Failed to load weather data';
        weatherIconPath.value = '';
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      weatherInfo.value = 'Error fetching weather data';
      weatherIconPath.value = '';
    }
  }

  // Map description to icon asset
  String getIconForDescription(String description) {
    description = description.toLowerCase();

    if (description.contains('clear')) {
      return 'assets/images/sun.svg';
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
      return 'assets/images/cloud.svg'; // default fallback
    }
  }

  // Update selected location
  void updateLocationAndWeather(Map<String, dynamic> locationData) {
    final name = locationData['name'] ?? '';
    final state = locationData['state'] ?? '';
    location.value = state.isNotEmpty ? '$name, $state' : name;
    getWeather(name, locationData['lat'], locationData['lon']);
  }

  // Placeholder for current location
  void useCurrentLocation() {
    location.value = "Current Location";
  }
}
