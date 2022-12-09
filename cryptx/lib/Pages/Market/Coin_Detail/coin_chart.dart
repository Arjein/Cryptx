import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Objects/API.dart';
import 'package:cryptx/Objects/candle.dart';
import 'package:flutter/material.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinChart extends StatelessWidget {
  CoinChart({required this.coinSymbol, super.key, required this.interval});
  final String coinSymbol;
  final String interval;

  late List<CandleData> candles;

  _buildFuture() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement initState

    return Center(
      child: FutureBuilder(
        future: API().fetchChartforLib(coinSymbol, interval),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            candles = snapshot.data!;
            //return ChartWidget(candles: candles!);
            return InteractiveChart(
              candles: candles,
              overlayInfo: (candle) {
                return {
                  "Date": DateTime.fromMillisecondsSinceEpoch(candle.timestamp)
                      .toString(),
                  "Open": candle.open?.toStringAsFixed(8) ?? "-",
                  "Close": candle.close?.toStringAsFixed(8) ?? "-",
                };
              },
              initialVisibleCandleCount: 40,
              style: ChartStyle(
                volumeColor: AppColors.lightBlue.withOpacity(0.5),
                priceGridLineColor: AppColors.lightBlue,
                priceLabelStyle:
                    const TextStyle(fontSize: 12, color: AppColors.lightBlue),
                timeLabelStyle:
                    const TextStyle(fontSize: 12, color: AppColors.lightBlue),
                selectionHighlightColor: AppColors.lightBlue.withOpacity(0.2),
                overlayBackgroundColor: AppColors.lightBlue.withOpacity(0.6),
                overlayTextStyle: TextStyle(color: Colors.red[100]),

                volumeHeightFactor: 0.2, // volume area is 20% of total height
              ),
            );
          } else if (snapshot.hasError) {
            return const Text("ERROR LOADING DATA!");
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key, required this.candles});
  final List<Candle> candles;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CurrentUser.deviceHeight! * 0.4,
      child: SfCartesianChart(
        axes: <ChartAxis>[
          NumericAxis(name: 'Y-Axis', opposedPosition: true, isVisible: false),
        ],
        series: <ChartSeries<Candle, DateTime>>[
          CandleSeries<Candle, DateTime>(
            dataSource: candles,
            xValueMapper: (Candle c, _) => c.dt,
            lowValueMapper: (Candle c, _) => c.low,
            highValueMapper: (Candle c, _) => c.high,
            openValueMapper: (Candle c, _) => c.open,
            closeValueMapper: (Candle c, _) => c.close,
            bullColor: Colors.green,
            bearColor: Colors.red,
            enableSolidCandles: true,
            enableTooltip: true,
          ),
          ColumnSeries<Candle, DateTime>(
            dataSource: candles,
            xValueMapper: (Candle c, _) => c.dt,
            yValueMapper: (Candle c, _) => (c.volume! / 2),
            yAxisName: 'Y-Axis',
            opacity: 0.5,
            width: 0.5,
          )
        ],
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          zoomMode: ZoomMode.x,
          enablePanning: true,
          maximumZoomLevel: 0.03,
        ),
        primaryXAxis: DateTimeAxis(
            visibleMinimum: candles[candles.length - 30].dt,
            visibleMaximum: candles[candles.length - 1].dt,
            maximum:
                candles[candles.length - 1].dt!.add(const Duration(days: 5))),
        primaryYAxis: NumericAxis(
          opposedPosition: true,
          tickPosition: TickPosition.inside,
          labelStyle: const TextStyle(
            fontSize: 9,
          ),
          rangePadding: ChartRangePadding.round,
          numberFormat: NumberFormat("#,##0.00##", "en_US"),
        ),
      ),
    );
  }
}
