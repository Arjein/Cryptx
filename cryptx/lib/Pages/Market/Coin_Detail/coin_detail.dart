import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Objects/providers.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cryptx/Objects/candle.dart';

class CoinDetail extends StatelessWidget {
  CoinDetail({super.key, required this.coin});
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: const <Widget>[
            CoinChart() ?? CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
