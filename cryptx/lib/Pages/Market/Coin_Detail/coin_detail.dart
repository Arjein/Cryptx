import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_chart.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_detail_widget.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/trade_widget.dart';
import 'package:flutter/material.dart';

class CoinDetail extends StatelessWidget {
  CoinDetail({super.key, required this.coin});
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    debugPrint("coindetail: ${coin.current_price}");
    return Scaffold(
      appBar: AppBar(title: Text(coin.id.toUpperCase())),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 120, child: Image.network(coin.image)),
            const SizedBox(
              height: 20,
            ),
            CoinDetailWidget(coin: coin),
            CoinChart(coinSymbol: coin.symbol),
            const TradeWidget(),
            // Those shouldn't be in a row. Edit them in column. Implement the buy sell mech
          ],
        ),
      ),
    );
  }
}
