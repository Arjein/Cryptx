// ignore_for_file: avoid_unnecessary_containers

import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Pages/Settings/settings_page.dart';
import 'package:cryptx/Pages/Wallet/portfolio.dart';
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
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const Settings_Screen()),
                    ),
                  );
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WalletWidget(),
            const Portfolio(),
          ],
        ),
      ),
    );
  }
}
