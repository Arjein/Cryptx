import 'package:cryptx/Colors/app_colors.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/TradeButton.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/coin_chart.dart';
import 'package:cryptx/Providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinDetail extends StatefulWidget {
  CoinDetail({super.key, required this.coin});
  final Coin coin;

  @override
  State<CoinDetail> createState() => _CoinDetailState();
}

class _CoinDetailState extends State<CoinDetail> {
  late TextEditingController _controller;
  bool isLoading_buy = false;

  @override
  void initState() {
    // TODO: implement initState
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("coindetail: ${widget.coin.current_price}");
    return Scaffold(
      appBar: AppBar(title: Text(widget.coin.id.toUpperCase())),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CoinChart(coinSymbol: widget.coin.symbol),
            SizedBox(
              height: 30,
            ),
            CoinDetailWidget(coin: widget.coin),
            SizedBox(
              height: 70,
            ),
            // Those shouldn't be in a row. Edit them in column. Implement the buy sell mech
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 130,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.obsidian_invert),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.attach_money,
                          color: AppColors.obsidian_invert),
                      hintText: "Amount",
                      border: InputBorder.none,
                    ),
                    controller: _controller,
                    autocorrect: false,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Container(
                  width: 130,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.obsidian_invert),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.money_off,
                          color: AppColors.obsidian_invert),
                      hintText: "Amount",
                      border: InputBorder.none,
                    ),
                    controller: _controller,
                    autocorrect: false,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                !isLoading_buy
                    ? TradeButton(
                        onPressed: () async {
                          setState(() {
                            isLoading_buy = true;
                          });

                          await Future.delayed(Duration(seconds: 2));
                          setState(() {
                            isLoading_buy = false;
                          });
                        },
                        text: "Buy",
                        color: Colors.green,
                      )
                    : Center(child: CircularProgressIndicator()),
                TradeButton(
                  onPressed: () {},
                  text: "Sell",
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CoinDetailWidget extends ConsumerWidget {
  const CoinDetailWidget({required this.coin, super.key});
  final Coin coin;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Coin> cl = ref.watch(marketProvider).value;
    var c = cl.where((element) => element.id == coin.id).first;

    debugPrint(c.toString());
    return Container(
      alignment: Alignment.center,
      child: c != null
          ? Text(
              "\$ ${c.current_price}",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white),
            )
          : const CircularProgressIndicator(),
    );
  }
}
