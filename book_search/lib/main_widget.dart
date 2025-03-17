import 'package:flutter/material.dart';

import 'package:book_search/config/router/app_router.dart';
import 'package:book_search/config/theme/app_theme.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme().getThemeData(),
      debugShowCheckedModeBanner: false,
      title: 'Book search',
      routerConfig: appRouter,
    );
  }
}
