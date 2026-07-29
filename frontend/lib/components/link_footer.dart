import 'package:flutter/material.dart';
import 'package:frontend/themes/text_styles.dart';

class LinkFooter extends StatelessWidget {
  final String firstLineText;
  final String secondLineText;
  final VoidCallback onTap;

  const LinkFooter({
    super.key,
    required this.firstLineText,
    required this.secondLineText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(firstLineText, style: AppTextStyles.buttonTextBlack),
        GestureDetector(
          onTap: onTap,
          child: Text(secondLineText, style: AppTextStyles.linkTextBlue),
        ),
      ],
    );
  }
}
