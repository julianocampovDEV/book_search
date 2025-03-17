import 'package:flutter/material.dart';

import 'package:book_search/config/theme/app_colors.dart';

class AppTheme {
  ThemeData getThemeData() => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.backgroundScaffold,
    focusColor: AppColors.primary,

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.selectionText,
      selectionHandleColor: AppColors.primary,
    ),
  );
}
