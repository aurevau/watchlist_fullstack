import 'package:flutter/material.dart';
import 'package:frontend/themes/colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondary,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
  );
}
