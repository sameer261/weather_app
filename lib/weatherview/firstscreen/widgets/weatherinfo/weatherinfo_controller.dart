import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/shared_prefences.dart';
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

  // Keys for SharedPreferences
  static const String _locationKey = 'saved_location';
  static const String _latitudeKey = 'saved_latitude';
  static const String _longitudeKey = 'saved_longitude';
  static const String _weatherInfoKey = 'saved_weather_info';
  static const String _weatherIconKey = 'saved_weather_icon';
  static const String _humidityKey = 'saved_humidity';
  static const String _windSpeedKey = 'saved_wind_speed';
  static const String _rainfallKey = 'saved_rainfall';

  @override
  void onInit() {
    super.onInit();
    loadSavedWeather();
  }

  Future<void> getCurrentLocationAndWeather() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      this.latitude.value = position.latitude;
      this.longitude.value = position.longitude;

      String city = await getCityFromCoordinates(
        position.latitude,
        position.longitude,
      );
      String state = await getStateFromCoordinates(
        position.latitude,
        position.longitude,
      );

      updateLocation(city, state);

      await getWeather("", position.latitude, position.longitude);
    } else {
      print("Location permission denied");
    }
  }

  Future<String> getCityFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    return "Current";
  }

  Future<String> getStateFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    return "Location";
  }

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

        // Save all updated weather data
        await saveWeatherToPrefs();
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

  Future<void> saveWeatherToPrefs() async {
    await LocalStorage.setString(_locationKey, location.value);
    await LocalStorage.setDouble(_latitudeKey, latitude.value);
    await LocalStorage.setDouble(_longitudeKey, longitude.value);
    await LocalStorage.setString(_weatherInfoKey, weatherInfo.value);
    await LocalStorage.setString(_weatherIconKey, weatherIconPath.value);
    await LocalStorage.setDouble(_humidityKey, humidity.value);
    await LocalStorage.setDouble(_windSpeedKey, windSpeed.value);
    await LocalStorage.setDouble(_rainfallKey, rainfall.value);
  }

  Future<void> loadSavedWeather() async {
    final savedLocation = LocalStorage.getString(_locationKey);
    final savedLat = LocalStorage.getDouble(_latitudeKey);
    final savedLon = LocalStorage.getDouble(_longitudeKey);
    final savedWeatherInfo = LocalStorage.getString(_weatherInfoKey);
    final savedWeatherIcon = LocalStorage.getString(_weatherIconKey);
    final savedHumidity = LocalStorage.getDouble(_humidityKey);
    final savedWindSpeed = LocalStorage.getDouble(_windSpeedKey);
    final savedRainfall = LocalStorage.getDouble(_rainfallKey);

    if (savedLocation != null &&
        savedLat != null &&
        savedLon != null &&
        savedWeatherInfo != null &&
        savedWeatherIcon != null) {
      location.value = savedLocation;
      latitude.value = savedLat;
      longitude.value = savedLon;
      weatherInfo.value = savedWeatherInfo;
      weatherIconPath.value = savedWeatherIcon;
      humidity.value = savedHumidity ?? 0.0;
      windSpeed.value = savedWindSpeed ?? 0.0;
      rainfall.value = savedRainfall ?? 0.0;
    }
  }
}
