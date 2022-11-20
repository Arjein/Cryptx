import 'dart:async';

import 'package:cryptx/Objects/API.dart';
import 'package:cryptx/Objects/coin.dart';

import 'package:cryptx/Pages/Market/coin_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO PROVIDER

final marketProvider = StateNotifierProvider<MarketNotifier, AsyncValue>(
    (ref) => MarketNotifier());

class MarketNotifier extends StateNotifier<AsyncValue> {
  MarketNotifier() : super(const AsyncValue.loading()) {
    fetchLoopWithdelay(const Duration(seconds: 20));
  }

  Future<void> fetchLoopWithdelay(Duration delay) async {
    while (true) {
      try {
        final data = await API().fetch_coin_data();
        state = AsyncValue.data(data);
      } catch (e) {
        state = AsyncValue.error(e, StackTrace.current);
      }

      await Future.delayed(delay);
    }
  }
}

class CoinListPage extends ConsumerWidget {
  const CoinListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Coin>? coinList = ref.watch(marketProvider).value;
    debugPrint("Zort$coinListİnden");

    return Scaffold(
      appBar: AppBar(
        title: const Text("T I T L E"),
      ),
      body: Center(
        child: CoinList(
          coinList: coinList,
        ),
      ),
    );
  }
}


// CoinList(coinList: coinList),
