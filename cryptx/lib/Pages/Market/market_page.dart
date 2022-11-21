import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Objects/providers.dart';
import 'package:cryptx/Pages/Market/coin_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO PROVIDER

class CoinListPage extends ConsumerWidget {
  const CoinListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Coin>? coinList = ref.watch(marketProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("T I T L E"),
      ),
      body: Center(
        child: coinList != null
            ? CoinList(coinList: coinList)
            : CircularProgressIndicator(),
      ),
    );
  }
}


// CoinList(coinList: coinList),
