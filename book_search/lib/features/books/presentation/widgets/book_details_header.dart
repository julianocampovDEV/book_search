import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:book_search/config/theme/app_colors.dart';

class BookDetailsHeader extends ConsumerWidget {
  final Widget child;
  final VoidCallback onPressed;

  const BookDetailsHeader({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          height: 400,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Center(child: child),
        ),

        Positioned(
          top: 20,
          left: 10,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
