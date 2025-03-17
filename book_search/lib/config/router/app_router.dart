import 'package:go_router/go_router.dart';

import 'package:book_search/config/router/route_name.dart';
import 'package:book_search/features/books/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: booksRoute,
  routes: [
    GoRoute(path: booksRoute, builder: (context, state) => const BooksScreen()),
    GoRoute(
      path: '$bookDetailsRoute/:isbn13',
      builder: (context, state) {
        final isbn13 = state.pathParameters['isbn13']!;
        return BookDetailsScreen(isbn13: isbn13);
      },
    ),
  ],
);
