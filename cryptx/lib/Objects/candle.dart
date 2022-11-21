class Candle {
  final DateTime? dt;
  final num? open;
  final num? high;
  final num? low;
  num? close;

  Candle({
    this.dt,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });
  @override
  String toString() => "Datetime: $dt\nOpen: $open\nClose:$close";

  factory Candle.fromJson(List<dynamic> jsonData) {
    return Candle(
      dt: DateTime.fromMillisecondsSinceEpoch(jsonData[0]),
      open: jsonData[1],
      high: jsonData[2],
      low: jsonData[3],
      close: jsonData[4],
    );
  }
}
