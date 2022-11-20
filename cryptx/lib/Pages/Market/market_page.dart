import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Objects/coingecko_data_service.dart';
import 'package:cryptx/Pages/Market/coin_list.dart';
import 'package:flutter/material.dart';

class CoinListPage extends StatelessWidget {
  CoinListPage({super.key, required this.coinList});
  List<Coin>? coinList;
  @override
  Widget build(BuildContext context) {
    debugPrint("Market Widget");
    return Scaffold(
      appBar: AppBar(
        title: const Text("C R Y P T X"),
      ),
      body: CoinList(coinList: coinList),
    );
  }
}
