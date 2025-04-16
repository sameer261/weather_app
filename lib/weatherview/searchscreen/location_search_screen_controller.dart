import 'package:get/get.dart';

class WeatherController extends GetxController {
  RxString location = ''.obs;

  void updateLocation(String newLoc) {
    location.value = newLoc;
    // Fetch weather logic here
  }

  void useCurrentLocation() {
    // Handle current location logic
    location.value = "Current Location"; // Temporary
  }
}
