import 'package:cryptx/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appDarkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.obsidian_darker,
    backgroundColor: AppColors.obsidian_darker,
//    primaryColor: AppColors.lightBlue,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(foregroundColor: AppColors.lightBlue)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
