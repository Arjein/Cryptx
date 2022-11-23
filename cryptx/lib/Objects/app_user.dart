import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

class AppUser {
  final String? email;
  final String? username;
  String? hash;
  Map<String, dynamic>? coins;
  

  AppUser(
    this.username,
    this.email,
    String password,
    this.coins,
  ) {
    hash = hashPassword(password);
  }
  @override
  String toString() =>
      "Username: $username\nEmail: $email\nPassword(Hash): $hash\nCoins:\n$coins";

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Map<String, dynamic> toFirestore() {
    return {
      "Username": username,
      "Email": email,
      "Hash": hash,
      "Coins": coins,
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
      data?["Coins"],
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> jsonData) {
    return AppUser(
      jsonData["Username"],
      jsonData["Email"],
      jsonData["Hash"],
      jsonData["Coins"],
    );
  }

  static Map<String, dynamic> toMap(AppUser model) => <String, dynamic>{
        'Email': model.email,
        'Username': model.username,
        'Hash': model.hash,
        'Coins': model.coins,
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
