import 'package:flutter/material.dart';
import 'package:weather_app/utils/color.dart';
import 'package:weather_app/weatherview/firstscreen/widgets/appbar/customappbar.dart';

// ignore: camel_case_types
class firstscreen extends StatelessWidget {
  const firstscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(gradient: radialGradientBackground),
        child: Column(
          children: const [
            CustomTopBar(), // Top bar
            Expanded(
              child: Center(
                child: Text(
                  'Hello, Weather!',
                  style: TextStyle(fontSize: 24, color: Colors.black87),
                ),
              ),
            ), // This keeps the gradient visible in the remaining area
          ],
        ),
      ),
    );
  }
}
