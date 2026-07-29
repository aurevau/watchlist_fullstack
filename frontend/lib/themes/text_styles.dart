// Configure text styles
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:frontend/themes/colors.dart';

class AppTextStyles {
  static const TextStyle pageTitle = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  static const TextStyle cardTitle = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static const TextStyle categoryText = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const TextStyle buttonTextBlack = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static const TextStyle linkTextBlue = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static const TextStyle buttonTextWhite = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 15,
  );

  static const TextStyle navbarText = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static const TextStyle introTitle = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w700,
    fontSize: 38,
  );

  static const TextStyle sectionTitle = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
}
