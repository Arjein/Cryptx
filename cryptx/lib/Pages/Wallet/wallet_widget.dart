import 'package:cryptx/Colors/app_colors.dart';
import 'package:flutter/material.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        border: Border.all(
          color: AppColors.obsidian_invert,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "C R Y P T X",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Container(
                  decoration: const ShapeDecoration(
                    shape: StadiumBorder(),
                    color: AppColors.lightBlue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      style: Theme.of(context).textTheme.titleMedium,
                      "Mert Arcan",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                          style: Theme.of(context).textTheme.titleSmall,
                          "50TL"),
                    ),
                    Container(
                      child: Text(
                          style: Theme.of(context).textTheme.overline,
                          "Balance"),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                  style: Theme.of(context).textTheme.caption,
                  "0x9183ehnuı1d91hx93hfh1oueofjq89980dhu"),
            )
          ],
        ),
      ),
    );
  }
}
