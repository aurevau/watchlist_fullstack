import 'package:flutter/material.dart';
import 'package:frontend/themes/colors.dart';

// Initial theme-setup for project
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
