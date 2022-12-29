import 'package:cryptx_cs50x/Objects/app_user.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyUser = "user";

  static Future<bool> setUser(AppUser user) async {
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
}
