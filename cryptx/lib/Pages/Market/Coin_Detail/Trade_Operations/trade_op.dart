import 'package:cryptx/Pages/Market/Coin_Detail/Trade_Operations/TradeButton.dart';
import 'package:flutter/material.dart';

import 'cash_input.dart';
import 'coin_output.dart';

class TradeOperationWidget extends StatelessWidget {
  const TradeOperationWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const CashInput(),
        const CoinOutput(),
        TradeButton(
            text: text,
            onPressed: () {
              if (text == "Buy") {
              } else if (text == "Sel") {}
              return;
            },
            color: text == "Buy" ? Colors.green : Colors.red),
      ],
    );
  }
}
