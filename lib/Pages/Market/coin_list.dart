import 'dart:async';

import 'package:cryptx_cs50x/Objects/CoinListObject.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:cryptx_cs50x/Pages/Market/coin_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinList extends StatelessWidget {
  const CoinList({super.key, this.querycoinList});

  final List<Coin>? querycoinList;

  @override
  Widget build(BuildContext context) {
    return CoinListObject.coinMap != null && CoinListObject.coinMap.isNotEmpty
        ? querycoinList != null
            ? querycoinList!.isNotEmpty
                ? ListView.builder(
                    itemCount: querycoinList!.length,
                    prototypeItem: CoinListTile(coin: querycoinList!.first),
                    itemBuilder: (context, index) {
                      return CoinListTile(
                        coin: querycoinList![index],
                      );
                    },
                  )
                : Center(
                    child: Text(
                    "Nothing found",
                    style: Theme.of(context).textTheme.headline4,
                  ))
            : ListView.builder(
                itemCount: CoinListObject.coinMap.values.length,
                prototypeItem:
                    CoinListTile(coin: CoinListObject.coinMap.values.first),
                itemBuilder: (context, index) {
                  return CoinListTile(
                    coin: CoinListObject.coinMap.values.toList()[index],
                  );
                },
              )
        : const CircularProgressIndicator();
  }
}
// Doge 8519 , Riggle = 0.393858