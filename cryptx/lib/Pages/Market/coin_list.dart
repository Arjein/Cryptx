import 'dart:async';

import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Objects/coingecko_data_service.dart';
import 'package:cryptx/Pages/Market/coin_list_tile.dart';
import 'package:flutter/material.dart';

class CoinList extends StatelessWidget {
  const CoinList({super.key, required this.coinList});
  final List<Coin>? coinList;
  @override
  Widget build(BuildContext context) {
    return coinList != null
        ? ListView.builder(
            itemCount: coinList!.length,
            itemBuilder: (context, index) {
              return CoinListTile(coin: coinList![index]);
            },
          )
        : const CircularProgressIndicator();
  }
}
