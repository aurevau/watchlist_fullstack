import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final int? maxLines;
  final ValueChanged<String>? onChanged;

  const InputTextField({
    super.key,
    this.maxLines = 1,
    required this.hintText,
    required this.isPassword,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: TextField(
            onChanged: onChanged,
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
