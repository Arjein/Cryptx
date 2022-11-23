import 'package:cryptx/Constants/app_colors.dart';
import 'package:flutter/material.dart';

class TradeButton extends StatelessWidget {
  const TradeButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color});
  final String text;
  final VoidCallback onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: StadiumBorder(),
          side: const BorderSide(
            color: AppColors.obsidian_invert,
            width: 0.5,
          ),
          backgroundColor: AppColors.obsidian_darker,
          foregroundColor: color,
        ),
        child: Text(text),
      ),
    );
  }
}
