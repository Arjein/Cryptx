import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:cryptx/Firebase/db.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Duration loginTime = const Duration(milliseconds: 1600);
final FirebaseAuth _auth = FirebaseAuth.instance;
Future<bool> Register_User(AppUser user) async {
  debugPrint('Sign-Up Name: ${user.email}, Password: ${user.hash}');
  try {
    await _auth.createUserWithEmailAndPassword(
        email: user.email!, password: user.hash!);
    await Future.delayed(loginTime);
    await registerAppUserDB(user);
    await Future.delayed(loginTime);
    debugPrint("Registration Successful");
    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}

Future<bool> Auth_User(String? email, String? password) async {
  // Login olurken kullanıcı olup olmadığını kontrol et
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    var bytes = utf8.encode(password!);
    var hash = sha256.convert(bytes).toString();
    await _auth.signInWithEmailAndPassword(email: email!, password: hash);
    await Future.delayed(loginTime);
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
  return true;
}
