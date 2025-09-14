import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/styles.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hint,
    this.isPassword = false,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        style: AppTextStyles.body,
        decoration: AppDropdownStyles.inputDecoration.copyWith(hintText: hint),
      ),
    );
  }
}
