import 'package:cryptx_cs50x/Constants/Constants.dart';
import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appDarkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bgColor,
    backgroundColor: AppColors.bgColor,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.obsidian,
            foregroundColor: AppColors.obsidian_invert)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
