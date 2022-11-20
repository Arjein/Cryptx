import 'dart:async';

import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Pages/Market/coin_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
// Doge 8519 , Riggle = 0.393858