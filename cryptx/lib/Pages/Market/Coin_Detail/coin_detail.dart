import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Objects/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cryptx/Objects/candle.dart';

class CoinDetail extends ConsumerWidget {
  CoinDetail({super.key, required this.coin});
  final Coin coin;
  late List<Candle>? _chartData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _chartData = ref.watch(chartProvider).value;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            _chartData != null && _chartData!.isNotEmpty
                ? SfCartesianChart(
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
                    primaryXAxis: DateTimeAxis(),
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
