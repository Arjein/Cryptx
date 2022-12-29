import 'dart:convert';
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
}
