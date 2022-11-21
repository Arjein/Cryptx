import 'package:cryptx/Colors/app_colors.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Objects/providers.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinListTile extends ConsumerWidget {
  const CoinListTile({super.key, required this.coin});
  final Coin coin;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: AppColors.obsidian_invert, width: 0.25)),
      child: InkWell(
        onTap: () {
          ref.read(coinProvider.notifier).update((state) => coin);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => CoinDetail(
                    coin: coin,
                  )),
            ),
          );
        },
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(coin.name),
              Text("${coin.current_price} \$"),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(coin.symbol.toUpperCase()),
              Text(
                "%${coin.price_change_percentage_24h.toStringAsFixed(2)}",
                style: TextStyle(
                    color: coin.price_change_percentage_24h > 0
                        ? Colors.green
                        : Colors.red),
              )
            ],
          ),
          leading: Image.network(coin.image),
        ),
      ),
    );
  }
}
