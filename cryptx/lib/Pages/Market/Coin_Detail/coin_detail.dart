import 'dart:convert';

import 'package:cryptx/Constants/Constants.dart';
import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/device_options.dart';
import 'package:cryptx/Objects/API.dart';
import 'package:cryptx/Objects/CoinListObject.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_chart.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_detail_widget.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/trade_widget.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:cryptx/Providers/coinlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interactive_chart/interactive_chart.dart';

class CoinDetail extends StatefulWidget {
  CoinDetail({required this.coin, super.key});
  Coin coin;

  @override
  State<CoinDetail> createState() => _CoinDetailState();
}

class _CoinDetailState extends State<CoinDetail> {
  late String interval;
  int selected = 0;
  @override
  void initState() {
    super.initState();
    interval = "1d";
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("${widget.coin.symbol} / USDT"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoinDetailWidget(coin: widget.coin),
            UserDevice.addVerticalSpace(context, 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Center(
                child: SizedBox(
                  height: UserDevice.getDeviceHeight(context) * 0.30,
                  child: CoinChart(
                      coinSymbol: widget.coin.symbol_binance!,
                      interval: interval),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      interval = "1d";
                      selected = 0;
                    });
                  },
                  style: selected == 0
                      ? OutlinedButton.styleFrom(
                          backgroundColor: AppColors.lightBlue,
                          foregroundColor: AppColors.obsidian_darker)
                      : null,
                  child: const Text("1d"),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      interval = "4h";
                      selected = 1;
                    });
                  },
                  style: selected == 1
                      ? OutlinedButton.styleFrom(
                          backgroundColor: AppColors.lightBlue,
                          foregroundColor: AppColors.obsidian_darker)
                      : null,
                  child: const Text("4h"),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      interval = "1h";
                      selected = 2;
                    });
                  },
                  style: selected == 2
                      ? OutlinedButton.styleFrom(
                          backgroundColor: AppColors.lightBlue,
                          foregroundColor: AppColors.obsidian_darker)
                      : null,
                  child: const Text("1h"),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      interval = "15m";
                      selected = 3;
                    });
                  },
                  style: selected == 3
                      ? OutlinedButton.styleFrom(
                          backgroundColor: AppColors.lightBlue,
                          foregroundColor: AppColors.obsidian_darker)
                      : null,
                  child: const Text("15m"),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      interval = "5m";
                      selected = 4;
                    });
                  },
                  style: selected == 4
                      ? OutlinedButton.styleFrom(
                          backgroundColor: AppColors.lightBlue,
                          foregroundColor: AppColors.obsidian_darker)
                      : null,
                  child: const Text("5m"),
                ),
              ],
            ),
            TradeWidget(coinSymbol: widget.coin.symbol_binance!)
          ],
        ),
      ),
    );
  }
}
