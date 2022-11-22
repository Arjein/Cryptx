import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/TradeButton.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_chart.dart';
import 'package:flutter/material.dart';

class CoinDetail extends StatelessWidget {
  CoinDetail({super.key, required this.coin});
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(coin.id.toUpperCase())),
      body: Center(
        child: Column(
          children: <Widget>[
            CoinChart(coinSymbol: coin.symbol),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TradeButton(
                  onPressed: () {},
                  text: "Buy",
                  color: Colors.green,
                ),
                TradeButton(
                  onPressed: () {},
                  text: "Sell",
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
