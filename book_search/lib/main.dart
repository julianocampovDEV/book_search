import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:book_search/init_dependencies.dart';
import 'package:book_search/main_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await initDependencies();

  runApp(const ProviderScope(child: MainWidget()));
}
