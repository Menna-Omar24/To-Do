import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: const TextTheme(
      labelSmall: TextStyle(
        fontSize: 12,
        color: AppColors.labelColor,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lightPrimaryColor,
    ),
  );
}
