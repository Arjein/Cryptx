import 'package:cryptx_cs50x/Constants/Constants.dart';
import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:cryptx_cs50x/Providers/coinlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CoinDetailWidget extends ConsumerWidget {
  const CoinDetailWidget({required this.coin, super.key});
  final Coin coin;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(coinMapProvider);
    
    return Container(
      alignment: Alignment.center,
      child: coin != null
          ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CurrentUser.deviceWidth! * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        coin.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: AppColors.obsidian_invert),
                      ),
                      CurrentUser.addHorizontalSpace(2),
                      SizedBox(
                        height: 33,
                        child: Image.network(coin.image!),
                      ),
                    ],
                  ),
                  CurrentUser.addVerticalSpace(1),
                  Row(
                    children: [
                      Text(
                        Constants.appPriceFormat(coin.current_price!)
                            .toString(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              coin.price_change_percentage_24h! > 0
                                  ? Icons.trending_up_rounded
                                  : Icons.trending_down_rounded,
                              color: coin.price_change_percentage_24h! > 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            Text(
                              coin.price_change! > 0
                                  ? Constants.appPriceFormat(coin.price_change!)
                                  : "-\$${coin.price_change!.toString().substring(1)}",
                              style: TextStyle(
                                color: coin.price_change_percentage_24h! > 0
                                    ? Colors.green.shade400
                                    : Colors.red.shade400,
                              ),
                            ),
                            Text(
                              " (${coin.price_change_percentage_24h!.toStringAsFixed(2)}%)",
                              style: TextStyle(
                                color: coin.price_change_percentage_24h! > 0
                                    ? Colors.green.shade400
                                    : Colors.red.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : SpinKitDoubleBounce(),
    );
  }
}
