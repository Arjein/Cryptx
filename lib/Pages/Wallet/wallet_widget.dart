import 'package:cryptx_cs50x/Constants/Constants.dart';
import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:cryptx_cs50x/Providers/user_balance_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: CurrentUser.deviceHeight! * 0.19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        border: Border.all(
          color: AppColors.lightBlue.withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "C R Y P T X",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 30, color: AppColors.lightBlue),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(style: Theme.of(context).textTheme.bodyLarge, "Balance"),
                  const SizedBox(
                    height: 8,
                  ),
                  const BalanceWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceWidget extends ConsumerWidget {
  const BalanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double? _currentBalance = ref.watch(userBalanceProvider);
    return Text(
        style:
            Theme.of(context).textTheme.headline6!.copyWith(letterSpacing: 1),
        Constants.appPriceFormat(_currentBalance!));
  }
}
