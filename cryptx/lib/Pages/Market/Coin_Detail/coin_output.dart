import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinOutput extends ConsumerWidget {
  const CoinOutput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Coin coin = ref.watch(coinDetailProvider) as Coin;
    num usd = ref.watch(usdProvider);
    debugPrint("Build me");
    num amount = usd != 0 ? usd / coin.current_price : 0;
    return Text(amount.toString());
  }
}
