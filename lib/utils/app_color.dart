import 'package:flutter/material.dart';

class   AppColors {
  static const Color appBlue = Color(0xFF525FE1);
  static const Color appOrange = Color(0xFFF86F03);
  static const Color appPinkWhite = Color(0xFFFFF6F4);
  static const Color appLightOrange = Color(0xFFfdce8d);
  static const Color appLightBlue = Color(0xFF7152E9);
  static const Color appDarkBlue = Color(0xFF231F40);
  static const Color appMidBlue = Color(0xFF6F6B80);
  static const Color appWhite = Color(0xFFffffff);
  static const Color appLightWhite = Color(0xFFEEEEEE);
  static const Color appBorder = Color(0xFFEEEEEE);
  static const Color appShadow = Color(0xFFF5F5F5);
  static const Color orange = Color(0xFFF38B01);
  static const Color appBlack = Color(0xFF000000);

  ///new added color
  static const Color appPrimaryColorPurple = Color(0xFF794DDA);
  static const Color appSecondaryColorBlue = Color(0xFF344CC2);
  static const Color appScaffoldColor = Color(0xFFF3EEFF);
  static const Color dotColor = Color(0xFFECE5FB);
  static const Color appColorWhite = Color(0xFFFFFFFF);
  static const Color appTextColorBlack = Color(0xFF473A63);
  static const Color appTextColorGrey = Color(0xFF625E6A);
  static const Color appTextFieldBorderColor = Color(0xFF7E788D);
  static const Color appAmberColor = Color(0xFFF99B1C);

  static const LinearGradient primaryGradientColor = LinearGradient(
      colors: [appSecondaryColorBlue, appPrimaryColorPurple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static LinearGradient grayGradientColor = LinearGradient(
      colors: [appMidBlue, Colors.grey.shade500],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
