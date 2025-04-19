import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/weatherinfo_controller.dart';

class LocationSearchScreenController extends GetxController {
  RxList<Map<String, dynamic>> locationSuggestions =
      <Map<String, dynamic>>[].obs;

  final String apiKey = '6fbcdad70318ecd7f0a756be6ff23b21';
  final WeatherInfoController weatherInfoController =
      Get.find<WeatherInfoController>();

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

  void updateLocationAndWeather(Map<String, dynamic> locationData) {
    final name = locationData['name'] ?? '';
    final state = locationData['state'] ?? '';

    weatherInfoController.updateLocation(name, state);
    weatherInfoController.getWeather(
      name,
      locationData['lat'],
      locationData['lon'],
    );
  }

  void useCurrentLocation() {
    weatherInfoController.location.value = "Current Location";
    // You can also call weatherInfoController.getWeather(...) with GPS coordinates
  }
}
