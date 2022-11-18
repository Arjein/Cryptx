import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:flutter/material.dart';

registerAppUserDB(AppUser user) async {
  FirebaseFirestore.instance
      .collection("Users")
      .withConverter(
        fromFirestore: AppUser.fromFirestore,
        toFirestore: (AppUser user, options) => user.toFirestore(),
      )
      .add(user);
}

readUserfromDB(String email) async {
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
}
