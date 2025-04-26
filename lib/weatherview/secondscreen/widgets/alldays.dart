import 'package:flutter/material.dart';

class NormalDayRow extends StatelessWidget {
  final String day;
  final String temperature;

  const NormalDayRow({required this.day, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 186,
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
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFFFF0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33F5E663),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
