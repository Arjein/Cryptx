import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyFirebaseUID = "uid";
  static const _keyEmail = 'email';
  static const _keyPassword = "password";
  static const _keyUser = "user";
  static const _keyUsername = "username";
  static const _deviceHeight = "height";
  static const _deviceWidth = "width";

  static Future<String?> getEmail() async {
    return await _storage.read(key: _keyEmail);
  }

  static Future<String?> getFirebaseUID() async {
    return await _storage.read(key: _keyFirebaseUID);
  }

  static Future<String?> getPassword() async {
    return await _storage.read(key: _keyPassword);
  }

  static Future<String?> getUsername() async {
    return await _storage.read(key: _keyUsername);
  }

  // This might be optimized
  static Future<bool> setUser(AppUser user, String password) async {
    try {
      await _storage.write(key: _keyUser, value: AppUser.serialize(user));
      await _storage.write(key: _keyEmail, value: user.email);
      await _storage.write(key: _keyPassword, value: password);
      await _storage.write(key: _keyUsername, value: user.username);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool?> setFirebaseUID(String UID) async {
    try {
      await _storage.write(key: _keyFirebaseUID, value: UID);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setUserCoins(AppUser user) async {
    try {
      await _storage.write(key: _keyUser, value: AppUser.serialize(user));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<AppUser?> getUser() async {
    return AppUser.deserialize(await _storage.read(key: _keyUser));
  }

  static Future<bool> deleteStorage() async {
    try {
      await _storage.delete(key: _keyUser);
      await _storage.delete(key: _keyPassword);
      await _storage.delete(key: _keyUsername);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
