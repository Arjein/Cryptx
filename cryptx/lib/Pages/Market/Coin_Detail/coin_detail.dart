import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_chart.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_detail_widget.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/trade_widget.dart';
import 'package:flutter/material.dart';

class CoinDetail extends StatelessWidget {
  const CoinDetail({super.key, required this.coin});
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    debugPrint("coindetail: ${coin.current_price}");
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: Text(coin.id.toUpperCase())),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 100,
              child: Image.network(coin.image),
            ),
            const SizedBox(
              height: 10,
            ),
            CoinDetailWidget(coin: coin),
            CoinChart(coinSymbol: coin.symbol),
            const TradeWidget(),
          ],
        ),
      ),
    );
  }
}
