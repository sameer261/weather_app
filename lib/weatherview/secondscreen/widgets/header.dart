import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 24,
            height: 24,
            color: Colors.transparent, // Placeholder for icon
          ),
          Text(
            'Next 7 Days',
            style: TextStyle(
              color: Color(0xFF313341),
              fontSize: 11,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: 24,
            height: 24,
            color: Colors.transparent, // Placeholder for icon
          ),
        ],
      ),
    );
  }
}
