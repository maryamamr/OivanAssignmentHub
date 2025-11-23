import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xFF614459);
  static Color secondaryColor = const Color(0xFF704B66);
  static LinearGradient backGroundGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF84677E), // top
      Color(0xFFB59DA5), // bottom
    ],
  );
}
