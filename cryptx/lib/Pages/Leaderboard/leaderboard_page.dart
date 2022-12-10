import 'package:cryptx/Pages/Market/Coin_Detail/Trade_Operations/tradingview_chart.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(height: 500, child: TWChart(binanceSymbol: "BTCUSDT")));
  }
}
