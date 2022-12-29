import 'dart:ffi';

import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Should be converted to StateFullWidget. Unnecessary provider.
final queryProvider = StateProvider<String?>(
  (ref) => null,
);

final orderListProvider = StateProvider<Map<String, dynamic>?>(
  (ref) => null,
);
