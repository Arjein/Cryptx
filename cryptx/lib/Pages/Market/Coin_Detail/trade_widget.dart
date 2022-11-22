import 'package:cryptx/Pages/Market/Coin_Detail/TradeButton.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/amount_input.dart';
import 'package:flutter/material.dart';
import 'coin_output.dart';

class TradeWidget extends StatelessWidget {
  const TradeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: const [
          TabBar(
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
            height: 200,
            child: TabBarView(
              children: [
                BuyWidget(
                  text: "Buy",
                ),
                Center(child: Text("Kişisel Bilgiler")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuyWidget extends StatefulWidget {
  const BuyWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  State<BuyWidget> createState() => _BuyWidgetState();
}

class _BuyWidgetState extends State<BuyWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const AmountInput(),
        const CoinOutput(),
        TradeButton(text: widget.text, onPressed: () {}, color: Colors.green),
      ],
    );
  }
}
