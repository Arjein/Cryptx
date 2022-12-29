import 'package:cryptx_cs50x/Objects/CoinListObject.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:cryptx_cs50x/Providers/basic_providers.dart';
import 'package:cryptx_cs50x/Providers/coinlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'exhange_widget.dart';

class TradeOperationWidget extends ConsumerWidget {
  const TradeOperationWidget({
    Key? key,
    required this.text,
    required this.coinSymbol,
  }) : super(key: key);
  final String text;
  final String coinSymbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(coinMapProvider);
    return ExchangeWidget(
      coin: CoinListObject.coinMap[coinSymbol]!,
      text: text,
      tether: CoinListObject.tether,
      
    );
  }
}
