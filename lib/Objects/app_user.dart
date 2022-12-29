import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class AppUser {
  Map<String, dynamic>? coins;
  AppUser({
    required this.coins,
  });

  factory AppUser.fromJson(Map<String, dynamic> jsonData) {
    debugPrint("FROMJSON:\n${jsonData["LimitOrders"].runtimeType} ");
    return AppUser(
      coins: jsonData["Coins"],
    );
  }

  static Map<String, dynamic> toMap(AppUser model) {
    return <String, dynamic>{
      'Coins': model.coins,
    };
  }

  static String serialize(AppUser model) => json.encode(AppUser.toMap(model));

  static AppUser? deserialize(String? json) {
    if (json != null) {
      return AppUser.fromJson(jsonDecode(json));
    } else {
      return null;
    }
  }
}
