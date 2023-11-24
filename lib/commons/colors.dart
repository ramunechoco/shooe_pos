import 'package:flutter/material.dart';

class ShooeColor {
  static const Color purple = Color(0xFF6B79F6);
  static const Color lightPurple = Color(0xFFF6F6FF);
  static const Color red = Color(0xFFF82828);
  static const Color darkGrey = Color(0xFF3E3E3E);
  static const Color mediumGrey = Color(0xFF999999);
  static const Color mediumLightGrey = Color(0xFFD0D0D0);
  static const Color lightGrey = Color(0xFFE3E3E3);
  static const Color paleGrey = Color(0xFFF9FAFC);
  static const Color darkBackground = Color(0xFF2C2C2C);
  static const Color blueBackground = Color(0xFF2B5876);
  static const Color purpleBackground = Color(0xFF4E4376);
  static const Color mediumBlue = Color(0xFF3D4F77);
  static const Color skyBlue = Color(0xFF3391FF);

  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ShooeColor.blueBackground,
      ShooeColor.purpleBackground,
    ],
  );

  static const LinearGradient lightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF829FB2),
      Color(0xFF8E7FC1),
    ],
  );
}
