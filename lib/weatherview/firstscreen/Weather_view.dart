import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/tabbar/tabbar.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/locationwidget.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/weatherinfo.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/weatherinfo_controller.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/appbar/customappbar.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/weathermetric.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/tabbar/tabbar_controller.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({super.key});

  final WeatherInfoController weatherController = Get.put(
    WeatherInfoController(),
  );
  final TabIndexController tabBarController = Get.put(TabIndexController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(gradient: radialGradientBackground),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTopBar(),
            SizedBox(height: 12),
            LocationWidget(),
            SizedBox(height: 10),
            WeatherInfoWidget(),
            SizedBox(height: 10),
            WeatherDetailsWidget(),
            SizedBox(height: 16),
            CustomTabBar(),
          ],
        ),
      ),
    );
  }
}
