class Candle {
  final DateTime? dt;
  final double? open;
  final double? high;
  final double? low;
  double? close;
  final double? volume;
  Candle({
    required this.dt,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
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
        volume: double.parse(jsonData[5]));
  }
}
