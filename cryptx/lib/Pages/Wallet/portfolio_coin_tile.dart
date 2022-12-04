import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:flutter/material.dart';

class PortfolioCoinTile extends StatelessWidget {
  const PortfolioCoinTile({super.key, required this.coin});
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    num coinAmount = CurrentUser.user!.coins![coin.symbol];
    num coinBalance =
        CurrentUser.user!.coins![coin.symbol] * coin.current_price;
    return SizedBox(
      child: InkWell(
        onTap: () {},
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(coin.name),
              Text(coinAmount.toStringAsFixed(6)),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(coin.current_price.toString()),
              Text(coinBalance.toStringAsFixed(6)),
            ],
          ),
          leading: Image.network(coin.image!, width: 35),
        ),
      ),
    );
  }
}
