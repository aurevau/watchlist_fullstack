import 'package:flutter/material.dart';
import 'package:frontend/themes/colors.dart';
import 'package:frontend/themes/text_styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressedButton;
  final String buttonText;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressedButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: GestureDetector(
            onTap: onPressedButton,
            child: Text(buttonText, style: AppTextStyles.buttonTextWhite),
          ),
        ),
      ),
    );
  }
}
