import 'package:cryptx/Constants/Constants.dart';
import 'package:cryptx/Constants/device_options.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Providers/coinlist_provider.dart';
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
                  horizontal: UserDevice.getDeviceWidth(context) * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        coin.symbol,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      UserDevice.addHorizontalSpace(context, 1),
                      SizedBox(
                        height: 33,
                        child: Image.network(coin.image!),
                      ),
                    ],
                  ),
                  UserDevice.addVerticalSpace(context, 1),
                  Text(
                    coin.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  UserDevice.addVerticalSpace(context, 1),
                  Text(
                    Constants.appPriceFormat(coin.current_price!).toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  UserDevice.addVerticalSpace(context, 1),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: coin.price_change_percentage_24h! > 0
                            ? Colors.green.shade400
                            : Colors.red.shade400,
                      ),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            coin.price_change_percentage_24h! > 0
                                ? Icons.trending_up_rounded
                                : Icons.trending_down_rounded,
                            color: coin.price_change_percentage_24h! > 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        const WidgetSpan(
                            child: SizedBox(
                          width: 3,
                        )),
                        TextSpan(
                            text: coin.price_change! > 0
                                ? Constants.appPriceFormat(coin.price_change!)
                                : "-\$${coin.price_change!.toString().substring(1)}"),
                        TextSpan(
                          text:
                              " (${coin.price_change_percentage_24h!.toStringAsFixed(2)}%)",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SpinKitDoubleBounce(),
    );
  }
}
