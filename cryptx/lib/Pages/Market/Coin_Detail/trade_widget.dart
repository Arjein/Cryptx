import 'package:cryptx/Constants/device_options.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/Trade_Operations/trade_op.dart';
import 'package:flutter/material.dart';

class TradeWidget extends StatelessWidget {
  const TradeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: "Buy",
              ),
              Tab(
                text: "Sell",
              )
            ],
          ),
          SizedBox(
            height: UserDevice.getDeviceHeight(context) * 25 / 100,
            child: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                TradeOperationWidget(
                  text: "Buy",
                ),
                TradeOperationWidget(
                  text: "Sell",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
