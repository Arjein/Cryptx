import 'package:cryptx/Constants/Constants.dart';
import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_detail.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinListTile extends StatelessWidget {
  const CoinListTile({super.key, required this.coin});
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.obsidian,
      shape: const RoundedRectangleBorder(
          side: BorderSide(
        color: AppColors.obsidian_invert,
        width: 0.1,
      )),
      child: InkWell(
        onTap: () {
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
              Text(Constants.appPriceFormat(coin.current_price!)),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(coin.symbol.toUpperCase()),
              coin.price_change_percentage_24h != null
                  ? Text(
                      "${coin.price_change_percentage_24h?.toStringAsFixed(2)}%",
                      style: TextStyle(
                          color: coin.price_change_percentage_24h! > 0
                              ? Colors.green
                              : Colors.red),
                    )
                  : const Text("***")
            ],
          ),
          leading: Image.network(coin.image!),
        ),
      ),
    );
  }
}
