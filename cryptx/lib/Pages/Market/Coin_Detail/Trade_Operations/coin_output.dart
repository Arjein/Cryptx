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
    num amount = usd != 0 ? usd / coin.current_price : 0;

    //return Text(amount.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextField(
        decoration: InputDecoration(
          icon: SizedBox(height: 30, child: Image.network(coin.image)),
          hintText: "Coin",
          border: InputBorder.none,
        ),
        controller:
            TextEditingController(text: "$amount ${coin.symbol.toUpperCase()}"),
        readOnly: true,
        autocorrect: false,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (value) {
          ref.watch(coin_usdProvider.notifier).update((state) =>
              value != "" ? num.parse(value) / coin.current_price : 0);
        },
      ),
    );
  }
}
