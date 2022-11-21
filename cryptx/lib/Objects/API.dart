import 'dart:convert';
import 'dart:ffi';

import 'package:cryptx/Objects/candle.dart';
import 'package:flutter/material.dart';

import 'coin.dart';
import 'package:http/http.dart' as http;

class API {
  Future<List<Coin>> fetchMarket() async {
    List<Coin> _coinList = <Coin>[];
    final resp = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=60&page=1&sparkline=false&price_change_percentage=24h"));

    try {
      // If the call to the server was successful, parse the JSON
      List<dynamic> decoded = json.decode(resp.body);
      for (dynamic coin in decoded) {
        _coinList.add(Coin.fromJson(coin));
      }
      return _coinList;
    } catch (e) {
      // If that call was not successful, throw an error.
      throw Exception('CoinGecko!:$e');
    }
  }

  Future<List<Candle>> fetchChart(String coinId) async {
    try {
      List<Candle> _chartData = <Candle>[];

      Uri request = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/$coinId/ohlc?vs_currency=usd&days=7");

      final resp = await http.get(request);

      List<dynamic> decodedResp = json.decode(resp.body);
      debugPrint(decodedResp[0].toString());

      for (dynamic day in decodedResp) {
        _chartData.add(Candle.fromJson(day));
      }
      debugPrint(_chartData[_chartData.length - 1].toString());
      return _chartData;
    } catch (e) {
      throw Exception("CoinGecko Graph Exception:$e");
    }
  }

  saptrial() async {
    Uri request = Uri.parse("https://api.binance.com/sapi/v1/margin/allAssets");
    final resp = await http.get(request);
  }
}
