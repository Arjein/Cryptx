import 'package:cryptx/Objects/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'device_options.dart';

class CurrentUser {
  static AppUser? user;
  static User? firebaseUser;
}
