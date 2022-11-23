import 'package:flutter/material.dart';

class UserDevice {
  num getDeviceHeight(context) => MediaQuery.of(context).size.height;
  num getDeviceWidth(context) => MediaQuery.of(context).size.width;
}
