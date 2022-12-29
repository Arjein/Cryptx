import 'dart:convert';
import 'package:flutter/services.dart';

import 'API.dart';
import 'coin.dart';

class CoinListObject {
  static Coin tether = Coin(
    name: "Tether",
    symbol: "USDT",
    current_price: 1,
    image:
        "https://assets.coingecko.com/coins/images/325/small/Tether.png?1668148663",
  );
  static late Map<String, Coin> coinMap;
  static late String binanceCoinFetch;

  Future<void> initCoinList() async {
    List<Coin> _coinList = <Coin>[];
    try {
      // If the call to the server was successful, parse the JSON
      var data = await rootBundle.loadString('assets/CoinList.json');
      List<dynamic> decoded = json.decode(data);

      for (dynamic coin in decoded) {
        _coinList.add(Coin.fromJson(coin));
      }

      coinMap = {for (Coin coin in _coinList) coin.symbol_binance!: coin};
      binanceCoinFetch = "%5B";
      for (String symbol in coinMap.keys) {
        binanceCoinFetch += "%22$symbol%22,";
      }
      binanceCoinFetch =
          binanceCoinFetch.substring(0, binanceCoinFetch.length - 1);
      binanceCoinFetch += "%5D";
      await API().fetchMarket();
      return;
    } catch (e) {
      throw Exception('Initcoinlist Error!: $e');
    }
  }

  updateCoinMap() async {
    await API().fetchMarket();
    return coinMap;
  }
}
