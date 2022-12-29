import 'package:cryptx_cs50x/Constants/Constants.dart';
import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:flutter/material.dart';

class PortfolioCoinTile extends StatelessWidget {
  const PortfolioCoinTile({super.key, required this.coin});
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    double coinAmount = CurrentUser.user!.coins![coin.symbol];
    double coinBalance =
        CurrentUser.user!.coins![coin.symbol] * coin.current_price;
    return ListTile(
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      horizontalTitleGap: CurrentUser.deviceWidth! * 0.03,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                coin.name,
                style: Constants.defaultTextStyle.copyWith(fontSize: 14),
              ),
              CurrentUser.addHorizontalSpace(0.5),
              Text(
                coin.symbol,
                style: Constants.defaultTextStyle.copyWith(fontSize: 10),
              ),
            ],
          ),
          Text(
            coinAmount.toStringAsFixed(6),
            style: Constants.defaultTextStyle.copyWith(fontSize: 14),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            coin.current_price.toString(),
          ),
          Text(
            Constants.appPriceFormat(coinBalance),
            style: Constants.defaultTextStyle.copyWith(fontSize: 11),
          ),
        ],
      ),
      leading: Image.network(coin.image!, width: 25),
    );
  }
}
