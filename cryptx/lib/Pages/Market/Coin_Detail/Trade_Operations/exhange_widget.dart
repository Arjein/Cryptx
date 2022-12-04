import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'TradeButton.dart';

// TODO Coin hesaplamalarını hallet. CoinGecko verileri USD olarak alıyormuş USDT olarak değil...!
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
    if (usdFocus.hasFocus) {
      coinTextController.clear();
      if (usdtTextController.text.isNotEmpty &&
          double.tryParse(usdtTextController.text) != null) {
        setState(() {
          coinTextController.text = (double.parse(usdtTextController.text) *
                  (widget.tether.current_price! / widget.coin.current_price!))
              .toStringAsFixed(12);

          amount = double.parse(coinTextController.text);
          debugPrint("Amount: $amount");
        });
      }
    }
  }

  _calculateUSDTValue() {
    if (coinFocus.hasFocus) {
      usdtTextController.clear();
      if (coinTextController.text.isNotEmpty &&
          double.tryParse(coinTextController.text) != null) {
        setState(() {
          usdtTextController.text = (double.parse(coinTextController.text) *
                  (widget.coin.current_price! / widget.tether.current_price!))
              .toStringAsFixed(6);
          debugPrint("Amount: $amount");
          amount = double.parse(coinTextController.text);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Builded");
    if (usdFocus.hasFocus) {
      _calculateCoinValue();
    }
    if (coinFocus.hasFocus) {
      _calculateUSDTValue();
    }
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            focusNode: usdFocus,
            decoration: InputDecoration(
              icon: SizedBox(
                  height: 30,
                  child: Image.network(
                      "https://assets.coingecko.com/coins/images/325/small/Tether.png?1668148663")),
              labelText: "USDT",
              border: InputBorder.none,
            ),
            controller: usdtTextController,
            autocorrect: false,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            focusNode: coinFocus,
            decoration: InputDecoration(
              icon: SizedBox(
                  height: 30, child: Image.network(widget.coin.image!)),
              labelText: widget.coin.symbol.toUpperCase(),
              border: InputBorder.none,
            ),
            controller: coinTextController,
            autocorrect: false,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
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
