import 'package:flutter/material.dart';

Widget buildCircularBackButton(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).pop(),
    child: Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(left: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.chevron_left,
          color: Color(0xFF212121),
          size: 24,
        ),
      ),
    ),
  );
}