import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/device_options.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Crypto Assets",
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              color: AppColors.obsidian_darker,
            ),
            height: UserDevice().getDeviceHeight(context) * 20 / 100,
            child: ListView(
              children: const [
                Text("1"),
                Text("1"),
                Text("1"),
                Text("1"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
