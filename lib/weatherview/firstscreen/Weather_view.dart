import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/locationwidget.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/weatherinfo.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/weatherinfo_controller.dart';
import 'package:weather_app/weatherview/searchscreen/location_search_screen_controller.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/appbar/customappbar.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({super.key});

  final WeatherInfoController weatherController = Get.put(
    WeatherInfoController(),
  );

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
            // Location City + State
          ],
        ),
      ),
    );
  }
}
