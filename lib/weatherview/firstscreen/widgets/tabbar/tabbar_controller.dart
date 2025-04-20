// tab_controller.dart
import 'package:get/get.dart';

class TabIndexController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
