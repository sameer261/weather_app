import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherController extends GetxController {
  RxString location = ''.obs; // To store selected location
  RxString weatherInfo = ''.obs; // To store weather data
  RxList<Map<String, dynamic>> locationSuggestions =
      <Map<String, dynamic>>[].obs; // To store location suggestions

  final String apiKey = '6fbcdad70318ecd7f0a756be6ff23b21';

  // Method to fetch location data from the API based on user search
  Future<void> searchLocation(String locationQuery) async {
    final url =
        'http://api.openweathermap.org/geo/1.0/direct?q=$locationQuery&limit=5&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          locationSuggestions.value = List<Map<String, dynamic>>.from(data);
        } else {
          locationSuggestions.value = [];
        }
      } else {
        locationSuggestions.value = [];
      }
    } catch (e) {
      print('Error: $e');
      locationSuggestions.value = [];
    }
  }

  // Method to fetch weather data for the selected location
  Future<void> getWeather(String city, double lat, double lon) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var weatherData = json.decode(response.body);
        // Updating weather info
        weatherInfo.value =
            'Weather: ${weatherData['weather'][0]['description']}\n'
            'Temperature: ${weatherData['main']['temp']}°C\n'
            'Humidity: ${weatherData['main']['humidity']}%';
      } else {
        weatherInfo.value = 'Failed to load weather data';
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      weatherInfo.value = 'Error fetching weather data';
    }
  }

  // Method to update location and fetch weather
  void updateLocationAndWeather(Map<String, dynamic> locationData) {
    location.value = locationData['name'] ?? 'Unknown';
    getWeather(location.value, locationData['lat'], locationData['lon']);
  }

  // Temporary placeholder for current location
  void useCurrentLocation() {
    location.value = "Current Location"; // Temporary
  }
}
