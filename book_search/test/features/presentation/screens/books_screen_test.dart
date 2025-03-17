import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:either_dart/src/either.dart';

import 'package:book_search/config/network/failure.dart';
import 'package:book_search/features/books/domain/domain.dart';
import 'package:book_search/features/books/presentation/books.dart';

final List<Book> mockBooks = [
  Book(
    title: "Flutter for Beginners",
    subtitle: "A guide to Flutter",
    isbn13: "1234567890123",
    price: "\$19.99",
    image: "https://itbook.store/img/books/9781617294136.png",
    url: "https://example.com/book",
  ),
  Book(
    title: "Dart in Action",
    subtitle: "Mastering Dart for Flutter",
    isbn13: "9876543210987",
    price: "\$24.99",
    image: "https://itbook.store/img/books/9781617294136.png",
    url: "https://example.com/dart",
  ),
];

class MockBooksNotifier extends BooksNotifier {
  MockBooksNotifier(AsyncValue<List<Book>> state)
    : super(booksRepository: MockBooksRepository()) {
    this.state = state;
  }
}

class MockBooksRepository extends BooksRepository {
  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    final Either<Failure, List<Book>> result = Right(mockBooks);

    return result;
  }

  @override
  Future<Either<Failure, BookDetails>> getBookDetails(String isbn13) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Book>>> searchBook(String query) {
    throw UnimplementedError();
  }
}

void main() {
  testWidgets('Should display empty state initially', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          booksProvider.overrideWith(
            (ref) => MockBooksNotifier(const AsyncValue.data([])),
          ),
        ],
        child: const MaterialApp(home: BooksScreen()),
      ),
    );

    expect(find.text("No books found."), findsOneWidget);
  });

  testWidgets('Should show loading indicator when state is loading', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          booksProvider.overrideWith(
            (ref) => MockBooksNotifier(const AsyncValue.loading()),
          ),
        ],
        child: const MaterialApp(home: BooksScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should display an error message when state has an error', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          booksProvider.overrideWith(
            (ref) => MockBooksNotifier(
              const AsyncValue.error("Failed to load books", StackTrace.empty),
            ),
          ),
        ],
        child: const MaterialApp(home: BooksScreen()),
      ),
    );

    expect(find.text("Failed to load books"), findsOneWidget);
  });
}
