// ignore_for_file: avoid_unnecessary_containers

import 'package:cryptx/Colors/app_colors.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:flutter/material.dart';

import 'wallet_widget.dart';

class AppWallet extends StatelessWidget {
  const AppWallet({
    super.key,
    required this.appUser,
  });
  final AppUser appUser;
  @override
  Widget build(BuildContext context) {
    debugPrint("THIS IS APPWALLET");
    debugPrint(appUser.toString());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WalletWidget(appUser: appUser),
            ],
          ),
        ),
      ),
    );
  }
}
