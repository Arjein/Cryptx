import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {
  static String appPriceFormat(double Price) {
    if (Price > 0 && Price < 0.001) {
      return "<0.0001";
    }
    return "\$${NumberFormat("#,##0.00######", "en_US").format(Price)}";
  }

  static const TextStyle defaultTextStyle =
      TextStyle(color: AppColors.obsidian_invert);
}
