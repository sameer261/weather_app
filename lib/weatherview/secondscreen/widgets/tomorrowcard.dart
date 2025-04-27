import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RowActive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8,
      ), // Added padding
      child: Container(
        height: 108,
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.5, color: Colors.white.withOpacity(0.8)),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tomorrow',
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
                      '38°',
                      style: TextStyle(
                        color: Color(0xFF303345),
                        fontSize: 7,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 5),
                    SvgPicture.asset(
                      'assets/images/sun_cloud.svg',
                      width: 36,
                      height: 36,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _infoColumn('0 cm', 'assets/images/rainfall.svg'),
                _infoColumn('8 km/h', 'assets/images/wind.svg'),
                _infoColumn('40%', 'assets/images/humidity.svg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String value, String iconPath) {
    return Column(
      children: [
        Container(
          width: 22,
          height: 22,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SvgPicture.asset(iconPath, fit: BoxFit.contain),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Color(0xFF303345),
            fontSize: 7,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
