// ignore_for_file: unnecessary_this

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

class AppUser {
  String? publicKey;
  String? privateKey;
  final String? email;
  final String? username;
  String? hash;
  double balance = 0;

  AppUser(
    this.username,
    this.email,
    String password,
  ) {
    this.hash = hashPassword(password);
  }
  @override
  String toString() =>
      "Username: $username\nEmail: $email\nPassword(Hash): $hash";
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
      "Username": username,
      "Email": email,
      "Hash": hash,
    };
  }

  factory AppUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AppUser(
      data?["Username"],
      data?["Email"],
      data?["Hash"],
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> jsonData) {
    return AppUser(
      jsonData["Username"],
      jsonData["Email"],
      jsonData["Hash"],
    );
  }

  static Map<String, dynamic> toMap(AppUser model) => <String, dynamic>{
        'Email': model.email,
        'Username': model.username,
        'Hash': model.hash,
      };

  static String serialize(AppUser model) => json.encode(AppUser.toMap(model));

  static AppUser? deserialize(String? json) {
    if (json != null) {
      return AppUser.fromJson(jsonDecode(json));
    } else {
      return null;
    }
  }
}
