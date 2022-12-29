import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:cryptx_cs50x/Objects/CoinListObject.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'dart:math';
import 'TradeButton.dart';

class ExchangeWidget extends StatefulWidget {
  const ExchangeWidget({
    super.key,
    required this.coin,
    required this.text,
    required this.tether,
  });
  final Coin coin;
  final Coin tether;
  final String text;

  @override
  State<ExchangeWidget> createState() => _ExchangeWidgetState();
}

class _ExchangeWidgetState extends State<ExchangeWidget> {
  double amount = 0;
  final usdtTextController = TextEditingController();
  final coinTextController = TextEditingController();
  String operation = "Market";
  late FocusNode usdFocus = FocusNode();
  late FocusNode coinFocus = FocusNode();
  late final TextStyle exchangeTextStyle;

  void _initListeners() {
    coinTextController.addListener(_calculateUSDTValue);
    usdtTextController.addListener(_calculateCoinValue);
  }

  @override
  void initState() {
    // TODO: implement initState
    exchangeTextStyle = const TextStyle(fontSize: 11);
    _initListeners();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    coinTextController.dispose();
    usdtTextController.dispose();
    usdFocus.dispose();
    coinFocus.dispose();
    super.dispose();
  }

  _calculateCoinValue() {
    // Calculates the Coin value based on input USDT.
    if (operation == "Market") {
      if (usdFocus.hasFocus) {
        coinTextController.clear();
        if (usdtTextController.text.isNotEmpty &&
            double.tryParse(usdtTextController.text) != null) {
          setState(() {
            coinTextController.text = (double.parse(usdtTextController.text) *
                    (widget.tether.current_price! / widget.coin.current_price!))
                .toStringAsFixed(12);

            amount = double.parse(coinTextController.text);
          });
        }
      }
    }
  }

  _calculateUSDTValue() {
    // Calculates the USDT value based on input Coin.
    if (operation == "Market") {
      if (coinFocus.hasFocus) {
        usdtTextController.clear();
        if (coinTextController.text.isNotEmpty &&
            double.tryParse(coinTextController.text) != null) {
          setState(() {
            usdtTextController.text = (double.parse(coinTextController.text) *
                    (widget.coin.current_price! / widget.tether.current_price!))
                .toStringAsFixed(6);

            amount = double.parse(coinTextController.text);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Current Operation: $operation");
    if (operation == "Market") {
      if (usdFocus.hasFocus) {
        _calculateCoinValue();
      }
      if (coinFocus.hasFocus) {
        _calculateUSDTValue();
      }
    }

    return Row(
      children: [
        SizedBox(
          width: CurrentUser.deviceWidth! * 0.22,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    // Limit Operation will be functional in the future.

                    onPressed: null,
                    style: operation == "Limit"
                        ? OutlinedButton.styleFrom(
                            backgroundColor:
                                AppColors.obsidian_invert.withOpacity(0.15),
                            foregroundColor: AppColors.obsidian_invert,
                          )
                        : null,
                    child: Text(
                      "Limit",
                      style: exchangeTextStyle,
                    )),
                OutlinedButton(
                  onPressed: () {
                    if (operation != "Market") {
                      setState(() {
                        coinTextController.clear();
                        usdtTextController.clear();
                        operation = "Market";
                      });
                    }
                  },
                  style: operation == "Market"
                      ? OutlinedButton.styleFrom(
                          backgroundColor:
                              AppColors.obsidian_invert.withOpacity(0.15),
                          foregroundColor: AppColors.obsidian_invert,
                        )
                      : null,
                  child: Text(
                    "Market",
                    style: exchangeTextStyle,
                  ),
                ),
                TradeButton(
                  text: widget.text,
                  amount: amount,
                  operationType: operation,
                  coin: widget.coin,
                  color: widget.text == "Buy" ? Colors.green : Colors.red,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AmountField(
                focus: coinFocus,
                textController: coinTextController,
                opText: widget.text,
                symbol: widget.coin.symbol,
                isLimit: false,
              ),
              AmountField(
                focus: usdFocus,
                opText: widget.text,
                textController: usdtTextController,
                symbol: CoinListObject.tether.symbol,
                isLimit: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AmountField extends StatelessWidget {
  const AmountField({
    Key? key,
    required this.focus,
    required this.textController,
    required this.opText,
    required this.symbol,
    required this.isLimit,
    this.currentPrice,
  }) : super(key: key);
  final String opText;
  final FocusNode focus;
  final TextEditingController textController;
  final String symbol;
  final bool isLimit;
  final double? currentPrice;

  KeyboardActionsConfig _buildConfig() {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: AppColors.obsidian.withOpacity(0.9),
        defaultDoneWidget: const Text(
          "Done",
          style: TextStyle(
            color: AppColors.orange,
          ),
        ),
        actions: [
          KeyboardActionsItem(
            focusNode: focus,
            displayDoneButton: true,
            displayArrows: false,
          )
        ]);
  }

  String _calculateUserTotalAmount(String symbol, int wantedDigits) {
    double? totalAmount = CurrentUser.user!.coins![symbol];
    String result = "0.00";
    if (totalAmount != null) {
      double fraction =
          (totalAmount % 1 * pow(10, wantedDigits)).floorToDouble() /
              pow(10, wantedDigits);
      result =
          (totalAmount.truncate() + fraction).toStringAsFixed(wantedDigits);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    String userTotalCoinAmount = _calculateUserTotalAmount(symbol, 6);
    return KeyboardActions(
      disableScroll: true,
      tapOutsideBehavior: TapOutsideBehavior.translucentDismiss,
      config: _buildConfig(),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 4),
        child: TextField(
          focusNode: focus,
          style: TextStyle(fontSize: 13),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 12),
            alignLabelWithHint: true,
            suffixIcon: (opText == "Buy" && (symbol == "USDT" || isLimit)) ||
                    (opText == "Sell" && symbol != "USDT")
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        !isLimit
                            ? userTotalCoinAmount
                            : currentPrice!.toString(),
                        style: TextStyle(
                            color: AppColors.obsidian_invert.withOpacity(0.6),
                            fontSize: 11),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_box_outlined,
                            color: AppColors.obsidian_invert.withOpacity(0.8)),
                        onPressed: () {
                          !isLimit
                              ? textController.text = userTotalCoinAmount
                              : textController.text = currentPrice.toString();
                          focus.requestFocus();
                        },
                      ),
                    ],
                  )
                : null,
            label: Text(
              !isLimit
                  ? symbol != "USDT"
                      ? "Amount (${symbol.toUpperCase()})"
                      : "USDT"
                  : "Price (USDT)",
              style: const TextStyle(fontSize: 12),
            ),
          ),
          controller: textController,
          autocorrect: false,
          enableSuggestions: false,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
      ),
    );
  }
}
