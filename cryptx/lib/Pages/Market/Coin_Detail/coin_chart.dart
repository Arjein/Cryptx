import 'package:cryptx/Objects/candle.dart';
import 'package:cryptx/Providers/chart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinChart extends ConsumerWidget {
  const CoinChart({required this.coinSymbol, super.key});
  final String coinSymbol;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Candle>? _chartData = ref.watch(chartProvider).value;

    return _chartData != null
        ? SfCartesianChart(
            title: ChartTitle(
                alignment: ChartAlignment.far,
                text: coinSymbol != "USDT"
                    ? "${coinSymbol.toUpperCase()} / USDT"
                    : "${coinSymbol.toUpperCase()} / USD"),
            series: <CandleSeries>[
              CandleSeries<Candle, DateTime>(
                dataSource: _chartData,
                xValueMapper: (Candle point, _) => point.dt,
                lowValueMapper: (Candle point, index) => point.low,
                closeValueMapper: (Candle point, index) => point.close,
                highValueMapper: (Candle point, index) => point.high,
                openValueMapper: (Candle point, index) => point.open,
              ),
            ],
            primaryXAxis: DateTimeAxis(
                maximum: _chartData.last.dt!.add(Duration(days: 1))),
            primaryYAxis: NumericAxis(labelFormat: '\${value}'),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
