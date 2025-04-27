import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NormalDayRow extends StatelessWidget {
  final String day;
  final String temperature;
  final String iconPath; // new

  const NormalDayRow({
    required this.day,
    required this.temperature,
    required this.iconPath, // new
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.36),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.5, color: Colors.white.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: TextStyle(
                color: Color(0xFF303345),
                fontSize: 7,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text(
                  temperature,
                  style: TextStyle(
                    color: Color(0xFF303345),
                    fontSize: 7,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 5),
                SvgPicture.asset(iconPath),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
