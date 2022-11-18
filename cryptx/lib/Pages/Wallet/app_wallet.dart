// ignore_for_file: avoid_unnecessary_containers

import 'package:cryptx/Colors/app_colors.dart';
import 'package:cryptx/Pages/Wallet/coin_list.dart';
import 'package:flutter/material.dart';

import 'wallet_widget.dart';

class AppWallet extends StatelessWidget {
  const AppWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              WalletWidget(),
              SizedBox(
                height: 40,
              ),
              CoinList()
            ],
          ),
        ),
      ),
    );
  }
}
