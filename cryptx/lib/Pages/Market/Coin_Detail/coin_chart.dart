import 'package:cryptx/Objects/candle.dart';
import 'package:cryptx/Objects/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinChart extends ConsumerWidget {
  const CoinChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Candle>? _chartData = ref.watch(chartProvider).value ;
    return _chartData != null
        ? SfCartesianChart(
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
            primaryXAxis: DateTimeAxis(),
          )
        : const CircularProgressIndicator();
  }
}
