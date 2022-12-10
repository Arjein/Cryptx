import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TWChart extends StatelessWidget {
  const TWChart({super.key, required this.binanceSymbol});
  final String binanceSymbol;
/*
class="tradingview-widget-container"
<div id="tradingview_76672"></div>
 
 <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/symbols/$symbol/?exchange=BINANCE" rel="noopener" target="_blank"><span class="blue-text">$symbol Chart</span></a> by TradingView</div>

*/
  String _generateCode(symbol) {
    return """
<!-- TradingView Widget BEGIN -->
<div>
  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
  <script type="text/javascript">
  new TradingView.widget(
  {
  "autosize": true,
  "symbol": "BINANCE:$symbol",
  "interval": "D",
  "timezone": "Etc/UTC",
  "theme": "dark",
  "style": "1",
  "locale": "en",
  "toolbar_bg": "#f1f3f6",
  "enable_publishing": false,
  "save_image": false,
  "container_id": "tradingview_76672"
}
  );
  </script>
</div>
<!-- TradingView Widget END -->
""";
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: '',
      javascriptMode: JavascriptMode.unrestricted,
      backgroundColor: Colors.red,
      onWebViewCreated: (WebViewController controller) async {
        controller.loadUrl(Uri.dataFromString(
          _generateCode(binanceSymbol),
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString());
      },
    );
  }
}
