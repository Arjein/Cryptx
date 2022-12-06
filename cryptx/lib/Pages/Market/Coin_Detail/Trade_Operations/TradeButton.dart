import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Storage/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TradeButton extends StatefulWidget {
  const TradeButton({
    super.key,
    required this.text,
    required this.coin,
    required this.color,
    required this.amount,
  });
  final String text;
  final Coin coin;
  final Color color;
  final num amount;

  @override
  State<TradeButton> createState() => _TradeButtonState();
}

class _TradeButtonState extends State<TradeButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppUser user = CurrentUser.user!;
    num userbalance = user.coins!["USDT"] ?? 0;
    num totalCost = widget.coin.current_price! * widget.amount;
    num userTotalCoins = user.coins![widget.coin.symbol] ?? 0;
    debugPrint("User Balance: $userbalance\nTotalCost: $totalCost");
    return OutlinedButton(
      onPressed: () async {
        if (widget.text == "Buy") {
          debugPrint("Buy pressed!");
          debugPrint("User Balance: $userbalance\nTotalCost: $totalCost");
          if (userbalance >= totalCost) {
            // If Balance is enough
            if (user.coins![widget.coin.symbol] == null) {
              user.coins![widget.coin.symbol] = widget.amount;
            } else {
              user.coins![widget.coin.symbol] =
                  user.coins![widget.coin.symbol]! + widget.amount;
            }
            debugPrint("User Balance: $userbalance\nTotalCost: $totalCost");
            user.coins!["USDT"] -= totalCost;

            await UserSecureStorage.setUserCoins(user);
            debugPrint(user.coins.toString());
          } else {
            debugPrint("Not Enough Balance!");
          }
        } else if (widget.text == "Sell") {
          debugPrint("Sell Pressed1");
          if (userTotalCoins >= widget.amount && widget.amount != 0) {
            user.coins![widget.coin.symbol] -= widget.amount;
            debugPrint("İslem oldu");
            num earnedUSDT = widget.coin.current_price! * (widget.amount);
            user.coins!["USDT"] += earnedUSDT;
          } else {
            debugPrint(user.toString());
            debugPrint("Not enough coins");
          }
        }
      },
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        side: const BorderSide(
          color: AppColors.obsidian_invert,
          width: 0.5,
        ),
        backgroundColor: AppColors.obsidian_darker,
        foregroundColor: widget.color,
      ),
      child: Text(widget.text),
    );
  }
}
