// ignore_for_file: unnecessary_this

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

/*TODO
Add Username for users, display username on card.
make registration and shared preferences.
 */
class AppUser {
  final String? publicKey;
  final String? privateKey;
  final String? email;
  String? hash;
  double balance = 0;

  AppUser(
    this.publicKey,
    this.privateKey,
    this.email,
    String password,
  ) {
    this.hash = hashPassword(password);
  }

  bool addBalance(double cash) {
    this.balance += cash;
    return true;
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Map<String, dynamic> toFirestore() {
    return {
      "Email": email,
      "Hash": hash,
      "PublicKey": publicKey,
      "PrivateKey": privateKey,
    };
  }

  factory AppUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AppUser(
      null,
      null,
      data?["Email"],
      data?["Hash"],
    );
  }
}
