import 'dart:convert';

import 'coin.dart';
import 'package:http/http.dart' as http;

class API {
  Future<List<Coin>> fetch_coin_data() async {
    List<Coin> _coinList = <Coin>[];
    final resp = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=false&price_change_percentage=24h"));

    if (resp.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> decoded = json.decode(resp.body);
      for (dynamic coin in decoded) {
        _coinList.add(Coin.fromJson(coin));
      }
      return _coinList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Request Error!');
    }
  }
}
