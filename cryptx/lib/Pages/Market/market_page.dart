import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Objects/coingecko_data_service.dart';
import 'package:cryptx/Pages/Market/coin_list.dart';
import 'package:flutter/material.dart';

class CoinListPage extends StatelessWidget {
  const CoinListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("C R Y P T X"),
      ),
      body: CoinList(),
    );
  }
}
