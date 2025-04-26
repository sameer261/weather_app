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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics:
                            constraints.maxHeight < 700
                                ? BouncingScrollPhysics()
                                : NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTopBar(),
                            SizedBox(height: 20),
                            LocationWidget(),
                            SizedBox(height: 20),
                            WeatherInfoWidget(),
                            SizedBox(height: 10),
                            WeatherDetailsWidget(),
                            SizedBox(height: 20),
                            CustomTabBar(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
