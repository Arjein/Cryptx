import 'package:cryptx_cs50x/Constants/Constants.dart';
import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:cryptx_cs50x/Pages/Market/Coin_Detail/coin_detail.dart';
import 'package:cryptx_cs50x/Providers/basic_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinListTile extends StatelessWidget {
  const CoinListTile({super.key, required this.coin});
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: AppColors.obsidian,
        shape: const RoundedRectangleBorder(
            side: BorderSide(
          color: AppColors.lightBlue,
          width: 0.1,
        )),
        child: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => CoinDetail(
                      coin: coin,
                    )),
              ),
            );
          },
          child: ListTile(
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            horizontalTitleGap: CurrentUser.deviceWidth! * 0.04,
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            leading: SizedBox(
              width: CurrentUser.deviceWidth! * 0.08,
              child: Image.network(coin.image!),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(coin.name,
                    style: Constants.defaultTextStyle.copyWith(fontSize: 15)),
                Text(
                  Constants.appPriceFormat(coin.current_price!),
                  style: Constants.defaultTextStyle.copyWith(fontSize: 15),
                ),
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
                              ? Colors.green.shade400
                              : Colors.red.shade400,
                        ).copyWith(fontSize: 13),
                      )
                    : const Text("***")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
