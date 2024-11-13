import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TVChart extends StatefulWidget {
  const TVChart({super.key, required this.binanceSymbol});
  final String binanceSymbol;

  @override
  State<TVChart> createState() => _TVChartState();
}

class _TVChartState extends State<TVChart> {
  late String interval;
  late int selected;
  InAppWebViewController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    interval = "1d";
    selected = 0;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("rebuild with ${widget.binanceSymbol} and $interval");

    return Column(
      children: [
        SizedBox(
          height: CurrentUser.deviceHeight! * 0.5,
          child: InAppWebView(
            initialFile: "assets/tradingview/index.html",
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              transparentBackground: true,
              supportZoom: true,
              clearCache: true,
              disableVerticalScroll: true,
              disableHorizontalScroll: true,
            ),
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer(),
              ),
            },
            onWebViewCreated: (controller) {
              debugPrint("WebView Created");
              _controller = controller;
            },
            onLoadStop: (controller, url) {
              debugPrint(
                  "Symbol: ${widget.binanceSymbol}, Interval: $interval");
              _controller!.evaluateJavascript(
                source: "initChart('${widget.binanceSymbol}','$interval');",
              );
            },
            onConsoleMessage: (InAppWebViewController controller,
                ConsoleMessage consoleMessage) {
              debugPrint("console message: ${consoleMessage.message}");
            },
            /*onConsoleMessage: (controller, consoleMessage) {
              debugPrint("Console Message: ${consoleMessage.message}");
            },*/
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                setState(() {
                  interval = "1d";
                  selected = 0;
                  _controller!.reload();
                });
              },
              style: selected == 0
                  ? OutlinedButton.styleFrom(
                      backgroundColor: AppColors.lightBlue.withOpacity(0.8),
                      foregroundColor: AppColors.obsidian)
                  : null,
              child: const Text("1d"),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  interval = "4h";
                  selected = 1;
                  _controller!.reload();
                });
              },
              style: selected == 1
                  ? OutlinedButton.styleFrom(
                      backgroundColor: AppColors.lightBlue.withOpacity(0.8),
                      foregroundColor: AppColors.obsidian)
                  : null,
              child: const Text("4h"),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  interval = "1h";
                  selected = 2;
                  _controller!.reload();
                });
              },
              style: selected == 2
                  ? OutlinedButton.styleFrom(
                      backgroundColor: AppColors.lightBlue.withOpacity(0.8),
                      foregroundColor: AppColors.obsidian)
                  : null,
              child: const Text("1h"),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  interval = "15m";
                  selected = 3;
                  _controller!.reload();
                });
              },
              style: selected == 3
                  ? OutlinedButton.styleFrom(
                      backgroundColor: AppColors.lightBlue.withOpacity(0.8),
                      foregroundColor: AppColors.obsidian)
                  : null,
              child: const Text("15m"),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  interval = "5m";
                  selected = 4;
                  _controller!.reload();
                });
              },
              style: selected == 4
                  ? OutlinedButton.styleFrom(
                      backgroundColor: AppColors.lightBlue.withOpacity(0.8),
                      foregroundColor: AppColors.obsidian)
                  : null,
              child: const Text("5m"),
            ),
          ],
        ),
      ],
    );
  }
}
