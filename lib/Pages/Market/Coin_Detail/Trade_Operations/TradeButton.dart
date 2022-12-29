import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:cryptx_cs50x/Storage/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// TODO ADD Button ONpress ProgressIndıcator
class TradeButton extends StatefulWidget {
  const TradeButton({
    super.key,
    required this.text,
    required this.coin,
    required this.color,
    required this.amount,
    required this.operationType,
    this.limitPrice,
  });
  final String text;
  final double? limitPrice;
  final String operationType;
  final Coin coin;
  final Color color;
  final double amount;

  @override
  State<TradeButton> createState() => _TradeButtonState();
}

class _TradeButtonState extends State<TradeButton> {
  bool _isLoading = false;
  bool operationFailed = true;
  @override
  Widget build(BuildContext context) {
    double userbalance = CurrentUser.user!.coins!["USDT"] ?? 0;
    double totalCost = 0;
    double userTotalCoins = CurrentUser.user!.coins![widget.coin.symbol] ?? 0;
    late int operationTime;
    return _isLoading != true
        ? OutlinedButton(
            onPressed: () async {
              setState(() {
                operationTime = DateTime.now().millisecondsSinceEpoch;
                _isLoading = true;
              });
              debugPrint(widget.operationType);
              totalCost = widget.operationType == "Market"
                  ? widget.coin.current_price! * widget.amount
                  : ((widget.limitPrice ?? 0) * widget.amount);
              if (widget.text == "Buy") {
                debugPrint("Buy pressed!");
                debugPrint("User Balance: $userbalance\nTotalCost: $totalCost");
                debugPrint("amount ${widget.amount}");

                if (userbalance >= totalCost && totalCost != 0) {
                  // If Balance is enough
                  if (widget.operationType == "Market") {
                    if (CurrentUser.user!.coins![widget.coin.symbol] == null) {
                      CurrentUser.user!.coins![widget.coin.symbol] =
                          widget.amount;
                    } else {
                      CurrentUser.user!.coins![widget.coin.symbol] +=
                          widget.amount;
                    }
                    operationFailed = false;
                  }
                  CurrentUser.user!.coins!["USDT"] -= totalCost;
                  await UserSecureStorage.setUser(CurrentUser.user!);
                } else {
                  debugPrint("Not Enough Balance!");
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Not Enough Balance"),
                  ));
                  operationFailed = true;
                }
              } else if (widget.text == "Sell") {
                debugPrint("Sell Pressed1");
                if (userTotalCoins >= widget.amount && widget.amount != 0) {
                  if (widget.operationType == "Market") {
                    num earnedUSDT =
                        widget.coin.current_price! * (widget.amount);
                    CurrentUser.user!.coins!["USDT"] += earnedUSDT;
                  }
                  CurrentUser.user!.coins![widget.coin.symbol] -= widget.amount;
                  await UserSecureStorage.setUser(CurrentUser.user!);
                  operationFailed = false;
                } else {
                  debugPrint("Not enough coins");
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Not Enough Coins"),
                  ));
                  operationFailed = true;
                }
              }
              !operationFailed
                  ? await Future.delayed(const Duration(seconds: 2))
                  : null;
              setState(() {
                _isLoading = false;
                !operationFailed
                    ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor:
                            widget.text == "Buy" ? Colors.green : Colors.red,
                        content: widget.text == "Buy"
                            ? Text(
                                "${widget.amount} ${widget.coin.symbol} Bought!")
                            : Text(
                                "${widget.amount} ${widget.coin.symbol} Sold!")))
                    : null;
              });
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: AppColors.obsidian_invert,
                width: 0.5,
              ),
              backgroundColor: AppColors.obsidian,
              foregroundColor: widget.color,
            ),
            child: Text(widget.text),
          )
        : SpinKitWave(
            color: widget.color,
          );
  }
}
