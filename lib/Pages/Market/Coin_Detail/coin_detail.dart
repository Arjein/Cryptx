import 'dart:convert';
import 'package:cryptx_cs50x/Constants/Constants.dart';
import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:cryptx_cs50x/Pages/Market/Coin_Detail/tradingview_chart.dart';
import 'package:cryptx_cs50x/Pages/Market/Coin_Detail/coin_detail_widget.dart';
import 'package:cryptx_cs50x/Pages/Market/Coin_Detail/trade_widget.dart';
import 'package:flutter/material.dart';

class CoinDetail extends StatelessWidget {
  const CoinDetail({required this.coin, super.key});
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    debugPrint(CurrentUser.user.toString());
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "${coin.symbol} / USDT",
          style: Constants.defaultTextStyle,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          TradeWidget(coinSymbol: coin.symbol_binance!),
          CurrentUser.addVerticalSpace(3),
          CoinDetailWidget(coin: coin),
          CurrentUser.addVerticalSpace(1.2),
          TVChart(binanceSymbol: coin.symbol_binance!),
          CurrentUser.addVerticalSpace(5),
        ],
      ),
    );
  }
}
