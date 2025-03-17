import 'package:flutter/material.dart';

import 'package:book_search/config/theme/app_colors.dart';
import 'package:book_search/shared/shared.dart';

class BooksHeader extends StatelessWidget {
  final Widget? child;

  const BooksHeader({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScreenWidth(context),
      height: 250,
      color: AppColors.primary,
      child: Stack(
        children: [
          Positioned(top: 130, right: -60, child: _circularContainer()),
          Positioned(top: 60, right: -130, child: _circularContainer()),
          SizedBox(
            width: DeviceUtils.getScreenWidth(context),
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(
                  'Book search',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                child ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _circularContainer() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.whiteOpacity,
        borderRadius: BorderRadius.circular(400),
      ),
    );
  }
}
