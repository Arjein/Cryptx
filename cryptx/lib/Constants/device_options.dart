import 'package:flutter/material.dart';

class UserDevice {
  static num getDeviceHeight(context) => MediaQuery.of(context).size.height;
  static num getDeviceWidth(context) => MediaQuery.of(context).size.width;

  static addVerticalSpace(context, double size) {
    return SizedBox(
      height: getDeviceHeight(context) * size / 100,
    );
  }

  static addHorizontalSpace(context, double size) {
    return SizedBox(
      width: getDeviceWidth(context) * size / 100,
    );
  }
}
