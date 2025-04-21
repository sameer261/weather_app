import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HourlyWeatherController extends GetxController {
  RxList<Map<String, dynamic>> todayHourlyData = <Map<String, dynamic>>[].obs;
  RxBool isHourlyLoading = false.obs;
  final String apiKey = '6fbcdad70318ecd7f0a756be6ff23b21';

  Future<void> fetchTodayHourlyWeather(double lat, double lon) async {
    isHourlyLoading.value = true;
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final int timezoneOffsetSeconds = data['city']['timezone'];
        final Duration timezoneOffset = Duration(
          seconds: timezoneOffsetSeconds,
        );
        final DateTime now = DateTime.now().toUtc().add(timezoneOffset);

        todayHourlyData.value =
            (data['list'] as List)
                .map((e) {
                  final DateTime forecastUtc = DateTime.parse(e['dt_txt']);
                  final DateTime localTime = forecastUtc.add(timezoneOffset);
                  return {
                    "time": localTime,
                    "temp": e['main']['temp'],
                    "icon": e['weather'][0]['icon'],
                  };
                })
                .where(
                  (entry) =>
                      entry["time"].day == now.day &&
                      entry["time"].isAfter(now),
                )
                .toList();
      } else {
        todayHourlyData.clear();
      }
    } catch (e) {
      print("Error fetching hourly weather: $e");
      todayHourlyData.clear();
    } finally {
      isHourlyLoading.value = false;
    }
  }
}
