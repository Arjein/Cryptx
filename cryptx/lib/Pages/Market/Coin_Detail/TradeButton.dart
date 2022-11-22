import 'package:cryptx/Colors/app_colors.dart';
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
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(12),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: StadiumBorder(),
            side: const BorderSide(
              color: AppColors.obsidian_invert,
              width: 1,
            ),
            backgroundColor: AppColors.obsidian_darker,
            foregroundColor: color,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
