import 'dart:convert';
import 'package:cryptx/Objects/candle.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'CoinListObject.dart';
import 'coin.dart';
import 'package:http/http.dart' as http;

class API {
  Future<Map<String, Coin>> fetchMarket() async {
    final resp = await http.get(Uri.parse(
        "https://api.binance.com/api/v3/ticker/24hr?symbols=${CoinListObject.binanceCoinFetch}"));

    try {
      // If the call to the server was successful, parse the JSON
      List<dynamic> decoded = json.decode(resp.body);
      debugPrint("API works: Bitcoin Price: ${decoded[0]["lastPrice"]}");
      for (dynamic coin in decoded) {
        double currentPrice = double.parse(coin['lastPrice']);
        double priceChange = double.parse(coin['priceChange']);
        double priceChangePercent = double.parse(coin['priceChangePercent']);
        String symbol = coin["symbol"];
        CoinListObject.coinMap[symbol]!.current_price = currentPrice;
        CoinListObject.coinMap[symbol]!.price_change = priceChange;
        CoinListObject.coinMap[symbol]!.price_change_percentage_24h =
            priceChangePercent;
      }
      return CoinListObject.coinMap;
    } catch (e) {
      // If that call was not successful, throw an error.
      throw Exception('Binance!:$e');
    }
  }

  Future<List<Candle>> fetchChart(String coinSymbol, String interval) async {
    try {
      List<Candle> chartData = <Candle>[];
      debugPrint("${coinSymbol.toUpperCase()}USDT interval: $interval");
      Uri request = Uri.parse(
          "https://api.binance.com/api/v3/klines?symbol=${coinSymbol.toUpperCase()}USDT&interval=$interval");

      final resp = await http.get(request);
      debugPrint(resp.body);
      List<dynamic> decodedResp = json.decode(resp.body);
      debugPrint(decodedResp.toString());
      for (dynamic day in decodedResp) {
        chartData.add(Candle.fromJson(day));
      }

      return chartData;
    } catch (e) {
      throw Exception("Binance Graph Exception:$e");
    }
  }
}
