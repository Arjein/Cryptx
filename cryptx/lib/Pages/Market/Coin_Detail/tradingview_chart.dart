import 'dart:convert';

import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TWChart extends StatefulWidget {
  const TWChart({super.key, required this.binanceSymbol});
  final String binanceSymbol;

  @override
  State<TWChart> createState() => _TWChartState();
}

class _TWChartState extends State<TWChart> {
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
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                transparentBackground: true,
                supportZoom: true,
                clearCache: true,
                disableVerticalScroll: true,
                disableHorizontalScroll: true,
              ),
              ios: IOSInAppWebViewOptions(
                disallowOverScroll: true,
                alwaysBounceVertical: false,
              ),
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
