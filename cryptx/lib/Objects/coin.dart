// ignore_for_file: non_constant_identifier_names

class Coin {
  final String symbol;
  final String name;
  final String? symbol_binance;
  final String? image;
  double? current_price;
  double? price_change;
  double? price_change_percentage_24h;

  @override
  String toString() =>
      "Coin symbol: $symbol Coin Name: $name Coin C_Price: $current_price\n";

  Coin({
    required this.symbol,
    this.symbol_binance,
    required this.name,
    this.image,
    this.current_price,
  });

  factory Coin.fromJson(Map<String, dynamic> jsonData) {
    return Coin(
      symbol: jsonData["symbol"],
      name: jsonData["name"],
      symbol_binance: jsonData["symbol_binance"],
      image: jsonData["image"],
    );
  }

  static Map<String, dynamic> toJson(Coin coin) => <String, dynamic>{
        'symbol': coin.symbol,
        'name': coin.name,
        'symbol_binance': coin.symbol_binance,
        'image': coin.image,
      };
}
