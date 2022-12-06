import 'package:cryptx/Constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'entry_text_form_validator.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.textHolder,
    required this.obscure,
    required this.borderRadius,
    this.icon,
    this.validator,
    this.controller,
  });

  final String textHolder;
  final Icon? icon;
  final FormFieldValidator? validator;
  final bool obscure;
  final double borderRadius;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        autocorrect: false,
        style: const TextStyle(color: AppColors.obsidian_invert),
        obscureText: obscure,
        validator: validator ?? defaultValidator,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: AppColors.lightBlue,
              )),
          labelText: textHolder,
          labelStyle: TextStyle(color: AppColors.obsidian_invert),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
