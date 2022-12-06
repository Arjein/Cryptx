import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Constants/device_options.dart';
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
    return ListTile(
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      horizontalTitleGap: UserDevice.getDeviceWidth(context) * 0.04,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
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
    );
  }
}
