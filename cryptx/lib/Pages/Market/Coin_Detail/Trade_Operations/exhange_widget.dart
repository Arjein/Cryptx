import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Objects/CoinListObject.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'dart:math';
import 'TradeButton.dart';

class ExchangeWidget extends StatefulWidget {
  const ExchangeWidget(
      {super.key,
      required this.coin,
      required this.text,
      required this.tether});
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

  late FocusNode usdFocus = FocusNode();
  late FocusNode coinFocus = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    coinTextController.addListener(_calculateUSDTValue);
    usdtTextController.addListener(_calculateCoinValue);
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

  _calculateUSDTValue() {
    // Calculates the USDT value based on input Coin.
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

  @override
  Widget build(BuildContext context) {
    if (usdFocus.hasFocus) {
      _calculateCoinValue();
    }
    if (coinFocus.hasFocus) {
      _calculateUSDTValue();
    }
    return Column(
      children: [
        AmountField(
          focus: usdFocus,
          textController: usdtTextController,
          coinImage: CoinListObject.tether.image!,
          symbol: CoinListObject.tether.symbol,
        ),
        AmountField(
            focus: coinFocus,
            textController: coinTextController,
            coinImage: widget.coin.image!,
            symbol: widget.coin.symbol),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TradeButton(
            text: widget.text,
            amount: amount,
            coin: widget.coin,
            color: widget.text == "Buy" ? Colors.green : Colors.red,
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
    required this.coinImage,
    required this.symbol,
  }) : super(key: key);

  final FocusNode focus;
  final TextEditingController textController;
  final String coinImage;
  final String symbol;

  KeyboardActionsConfig _buildConfig() {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: AppColors.obsidian_darker.withOpacity(0.9),
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
      result = (totalAmount.truncate() + fraction).toStringAsFixed(2);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    String userTotalCoinAmount = _calculateUserTotalAmount(symbol, 2);
    return Expanded(
      child: KeyboardActions(
        disableScroll: true,
        tapOutsideBehavior: TapOutsideBehavior.translucentDismiss,
        config: _buildConfig(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: focus,
                  decoration: InputDecoration(
                    icon: SizedBox(height: 30, child: Image.network(coinImage)),
                    labelText: symbol.toUpperCase(),
                    border: InputBorder.none,
                  ),
                  controller: textController,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Text(
                userTotalCoinAmount,
                style: TextStyle(
                    color: AppColors.obsidian_invert.withOpacity(0.6)),
              ),
              IconButton(
                icon: Icon(Icons.add_box_outlined,
                    color: AppColors.obsidian_invert.withOpacity(0.8)),
                onPressed: () {
                  textController.text = userTotalCoinAmount;
                  focus.requestFocus();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
