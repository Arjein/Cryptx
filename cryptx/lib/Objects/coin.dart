import 'dart:convert';

class Coin {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double current_price;
  final double price_change_percentage_24h;

  @override
  String toString() =>
      "Coin id: $id\nCoin symbol: $symbol\nCoin Name: $name\nCoin C_Price: $current_price";

  Coin(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.current_price,
      required this.price_change_percentage_24h});

  factory Coin.fromJson(Map<String, dynamic> jsonData) {
    return Coin(
      id: jsonData["id"],
      symbol: jsonData["symbol"],
      name: jsonData["name"],
      image: jsonData["image"],
      current_price: jsonData["current_price"],
      price_change_percentage_24h: jsonData["price_change_percentage_24h"],
    );
  }

  static Map<String, dynamic> toJson(Coin coin) => <String, dynamic>{
        'id': coin.id,
        'symbol': coin.symbol,
        'name': coin.name,
        'image': coin.image,
        'current_Price': coin.current_price,
        'price_change_percentage_24h': coin.price_change_percentage_24h,
      };
}
