import 'dart:convert';
import 'package:cryptx_cs50x/Objects/API.dart';
import 'package:cryptx_cs50x/Objects/CoinListObject.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';


final coinMapProvider = StateNotifierProvider<CoinListNotifier, AsyncValue>(
    (ref) => CoinListNotifier());

class CoinListNotifier extends StateNotifier<AsyncValue> {
  CoinListNotifier() : super(const AsyncValue.loading()) {
    fetchLoopWithdelay(const Duration(seconds: 5));
  }

  Future<void> fetchLoopWithdelay(Duration delay) async {
    while (true) {
      try {
        final data = await API().fetchMarket();
        state = AsyncValue.data(data);
      } catch (e) {
        Exception("asd");
      }

      await Future.delayed(delay);
    }
  }
}
/*
dataStream() {
  final channel = IOWebSocketChannel.connect(
    "wss://stream.binance.com:9443/ws/!miniTicker@arr",
  );
  channel.stream.listen((message) {
    var getData = jsonDecode(message);

    for (dynamic o in getData) {
      double currentPrice = double.parse(o['c']);
      String symbol = o["s"];
      if (CoinListObject.coinMap[symbol] != null) {
        CoinListObject.coinMap[symbol]!.current_price = currentPrice;
        debugPrint(CoinListObject.coinMap.toString());
      }
    }
  });
}
*/