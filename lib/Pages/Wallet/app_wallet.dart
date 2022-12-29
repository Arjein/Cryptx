// ignore_for_file: avoid_unnecessary_containers

import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:cryptx_cs50x/Objects/app_user.dart';
import 'package:cryptx_cs50x/Pages/Wallet/portfolio.dart';
import 'package:flutter/material.dart';

import 'wallet_widget.dart';

class AppWallet extends StatelessWidget {
  const AppWallet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            WalletWidget(),
            Portfolio(),
          ],
        ),
      ),
    );
  }
}
