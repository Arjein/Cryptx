import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:cryptx/Storage/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TradeButton extends ConsumerWidget {
  const TradeButton({super.key, required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Coin coin = ref.watch(coinDetailProvider) as Coin;
    AppUser user = CurrentUser.user!;
    debugPrint(user.toString());
    num amount = ref.watch(usdProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: OutlinedButton(
        onPressed: () async {
          if (text == "Buy") {
            debugPrint("Buy pressed!");
            num buyPrice = amount * coin.current_price;
            debugPrint(buyPrice.toString());
            if (user.coins![coin.id] == null) {
              user.coins![coin.id] = amount;
            } else {
              user.coins![coin.id] = user.coins![coin.id]! + amount;
            }
            await UserSecureStorage.setUserCoins(user);

            debugPrint(user.coins.toString());
          } else if (text == "Sell") {
            debugPrint("Sell Pressed1");
          }
        },
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: const BorderSide(
            color: AppColors.obsidian_invert,
            width: 0.5,
          ),
          backgroundColor: AppColors.obsidian_darker,
          foregroundColor: color,
        ),
        child: Text(text),
      ),
    );
  }
}
