import 'package:cryptx/Objects/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUser {
  static AppUser? user;
  static User? firebaseUser;
  static double? deviceWidth;
  static double? deviceHeight;

  static addVerticalSpace(double size) {
    return SizedBox(
      height: deviceHeight! * size / 100,
    );
  }

  static addHorizontalSpace(double size) {
    return SizedBox(
      width: deviceWidth! * size / 100,
    );
  }
}
