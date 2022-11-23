import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Storage/user_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'db.dart';

Duration loginTime = const Duration(milliseconds: 1600);
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<bool> registerUser(AppUser user) async {
  debugPrint('Sign-Up Name: ${user.email}, Password: ${user.hash}');
  try {
    debugPrint("Email:" + user.email!);
    await _auth.createUserWithEmailAndPassword(
        email: user.email!, password: user.hash!);
    await registerAppUserDB(user, _auth.currentUser!);
    await Future.delayed(loginTime);

    debugPrint("Registration Successful");
    return true;
  } catch (e) {
    debugPrint("_auth Error$e");
    return false;
  }
}

Future<bool> authUser(String? email, String? password) async {
  // Login olurken kullanıcı olup olmadığını kontrol et
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    var bytes = utf8.encode(password!);
    var hash = sha256.convert(bytes).toString();
    await _auth.signInWithEmailAndPassword(email: email!, password: hash);
    await Future.delayed(loginTime);
    UserSecureStorage.setFirebaseUID(_auth.currentUser!.uid);
    CurrentUser.firebaseUser = _auth.currentUser;
    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
