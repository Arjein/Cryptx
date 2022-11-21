class Candle {
  final DateTime? dt;
  final num? open;
  final num? high;
  final num? low;
  final num? close;

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
      open: double.parse(jsonData[1]),
      high: double.parse(jsonData[2]),
      low: double.parse(jsonData[3]),
      close: double.parse(jsonData[4]),
    );
  }
}
