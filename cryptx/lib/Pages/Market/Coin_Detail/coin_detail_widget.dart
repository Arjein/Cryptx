import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CoinDetailWidget extends ConsumerWidget {
  const CoinDetailWidget({required this.c, super.key});
  final Coin c;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint(c.toString());

    return Container(
      alignment: Alignment.center,
      child: c != null
          ? Column(
              children: [
                Text(
                  "\$ ${c.current_price}",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          c.price_change_percentage_24h! > 0
                              ? Icons.trending_up_rounded
                              : Icons.trending_down_rounded,
                          color: c.price_change_percentage_24h! > 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      const WidgetSpan(
                          child: SizedBox(
                        width: 3,
                      )),
                      TextSpan(
                          text: "${c.price_change_percentage_24h}%",
                          style: Theme.of(context).textTheme.labelLarge),
                    ],
                  ),
                )
              ],
            )
          : SpinKitDoubleBounce(),
    );
  }
}
