import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherInfoController extends GetxController {
  RxString location = ''.obs;
  RxString weatherInfo = ''.obs;
  RxString weatherIconPath = ''.obs;

  final String apiKey = '6fbcdad70318ecd7f0a756be6ff23b21';

  Future<void> getWeather(String city, double lat, double lon) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body);
        final description = weatherData['weather'][0]['description'];
        final iconPath = getIconForDescription(description);

        double temp = weatherData['main']['temp'].toDouble();
        int roundedTemp = temp.round();

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
    }
  }

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

  void updateLocation(String city, String state) {
    location.value = state.isNotEmpty ? '$city, $state' : city;
  }
}
