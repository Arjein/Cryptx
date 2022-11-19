import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:flutter/material.dart';

Future<bool> registerAppUserDB(AppUser user) async {
  try {
    FirebaseFirestore.instance
        .collection("Users")
        .withConverter(
          fromFirestore: AppUser.fromFirestore,
          toFirestore: (AppUser user, options) => user.toFirestore(),
        )
        .add(user);
    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}

Future<AppUser?> readUserfromDB(String email) async {
  try {
    final ref = FirebaseFirestore.instance
        .collection("Users")
        .where('Email', isEqualTo: email)
        .withConverter(
          fromFirestore: AppUser.fromFirestore,
          toFirestore: (AppUser user, _) => user.toFirestore(),
        );

    final docSnap = await ref.get();
    final queryLen = docSnap.docs.length;
    if (queryLen == 1) {
      final AppUser user = docSnap.docs.elementAt(0).data();
      debugPrint("Retrieved User: $user");
      return user;
    } else {
      return null;
    }
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
