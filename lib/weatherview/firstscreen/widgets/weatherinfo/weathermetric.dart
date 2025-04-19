import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/weatherinfo/weatherinfo_controller.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final WeatherInfoController weatherController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Obx(() {
        if (weatherController.isWeatherLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Fetch data from the controller
        final humidity = weatherController.humidity.value;
        final windSpeed = weatherController.windSpeed.value;
        final rainfall = weatherController.rainfall.value;

        return Column(
          children: [
            _buildWeatherContainer(
              svgPath: 'assets/images/rainfall.svg',
              title: 'Rainfall',
              value: rainfall != 0.0 ? '$rainfall cm' : 'N/A',
              iconWidth: 18,
              iconHeight: 18,

              paddingBottom: 1,
            ),
            SizedBox(height: 5),
            _buildWeatherContainer(
              svgPath: 'assets/images/wind.svg',
              title: 'Wind Speed',
              value: '$windSpeed km/h',
              iconWidth: 18,
              iconHeight: 18,
              paddingTop: 3,
            ),
            SizedBox(height: 5),
            _buildWeatherContainer(
              svgPath: 'assets/images/humidity.svg',
              title: 'Humidity',
              value: '$humidity%',
              iconWidth: 24,
              iconHeight: 24,
              paddingTop: 1,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildWeatherContainer({
    required String svgPath,
    required String title,
    required String value,
    required double iconWidth,
    required double iconHeight,
    double paddingTop = 0,
    double paddingBottom = 0,
    double paddingLeft = 0,
    double paddingRight = 0,
  }) {
    return Container(
      width: double.infinity,
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.36),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.5,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Colors.white.withOpacity(0.50),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSvgIcon(
            svgPath,
            iconWidth,
            iconHeight,
            paddingTop: paddingTop,
            paddingBottom: paddingBottom,
            paddingLeft: paddingLeft,
            paddingRight: paddingRight,
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: customDark,
              fontSize: 8,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              value,
              style: TextStyle(
                color: customDark,
                fontSize: 8,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSvgIcon(
    String path,
    double width,
    double height, {
    double paddingTop = 3,
    double paddingBottom = 3,
    double paddingLeft = 3,
    double paddingRight = 3,
  }) {
    return Container(
      width: 22,
      height: 22,
      padding: EdgeInsets.only(
        top: paddingTop,
        bottom: paddingBottom,
        left: paddingLeft,
        right: paddingRight,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: Center(child: SvgPicture.asset(path, fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
