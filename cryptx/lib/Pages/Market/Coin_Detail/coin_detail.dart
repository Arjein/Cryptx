import 'dart:convert';

import 'package:cryptx/Constants/Constants.dart';
import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Objects/API.dart';
import 'package:cryptx/Objects/CoinListObject.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/tradingview_chart.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_chart.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_detail_widget.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/trade_widget.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:cryptx/Providers/coinlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interactive_chart/interactive_chart.dart';

class CoinDetail extends StatelessWidget {
  CoinDetail({required this.coin, super.key});
  Coin coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "${coin.symbol} / USDT",
          style: Constants.defaultTextStyle,
        ),
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TradeWidget(coinSymbol: coin.symbol_binance!),
          CurrentUser.addVerticalSpace(3),
          CoinDetailWidget(coin: coin),
          CurrentUser.addVerticalSpace(1.2),
          TWChart(binanceSymbol: coin.symbol_binance!),
          CurrentUser.addVerticalSpace(5),
        ],
      ),
    );
  }
}
