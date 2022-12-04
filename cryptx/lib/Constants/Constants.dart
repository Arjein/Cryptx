import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {
  static String appPriceFormat(double Price) {
    return "\$${NumberFormat("#,##0.00######", "en_US").format(Price)}";
    //return str
  }
}
