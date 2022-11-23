import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/Trade_Operations/TradeButton.dart';
import 'package:cryptx/Storage/user_secure_storage.dart';
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
          color: text == "Buy" ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}
