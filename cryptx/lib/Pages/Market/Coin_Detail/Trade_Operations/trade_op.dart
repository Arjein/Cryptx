import 'package:cryptx/Objects/CoinListObject.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'exhange_widget.dart';

class TradeOperationWidget extends ConsumerWidget {
  const TradeOperationWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Coin tether = CoinListObject.tether;
    return /*ExchangeWidget(
      coin: coin,
      text: text,
      tether: tether,
    );
    */
        Container();
  }
}
