import 'package:cryptx/Objects/API.dart';
import 'package:cryptx/Objects/candle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinChart extends StatefulWidget {
  const CoinChart({required this.coinSymbol, super.key});
  final String coinSymbol;

  @override
  State<CoinChart> createState() => _CoinChartState();
}

class _CoinChartState extends State<CoinChart> {
  List<Candle>? _chartData;
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  init() async {
    List<Candle> newData = await API().fetchChart(widget.coinSymbol, "1d");
    setState(() {
      _chartData = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _chartData != null
        ? SfCartesianChart(
            title: ChartTitle(
                alignment: ChartAlignment.far,
                text: widget.coinSymbol != "USDT"
                    ? "${widget.coinSymbol.toUpperCase()} / USDT"
                    : "${widget.coinSymbol.toUpperCase()} / USD"),
            series: <CandleSeries>[
              CandleSeries<Candle, DateTime>(
                dataSource: _chartData!,
                xValueMapper: (Candle point, _) => point.dt,
                lowValueMapper: (Candle point, index) => point.low,
                closeValueMapper: (Candle point, index) => point.close,
                highValueMapper: (Candle point, index) => point.high,
                openValueMapper: (Candle point, index) => point.open,
              ),
            ],
            primaryXAxis: DateTimeAxis(
                maximum: _chartData!.last.dt!.add(Duration(days: 1))),
            primaryYAxis: NumericAxis(labelFormat: '\${value}'),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
