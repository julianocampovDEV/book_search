import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:book_search/config/network/failure.dart';
import 'package:book_search/features/books/domain/domain.dart';
import 'package:book_search/features/books/infrastructure/infrastructure.dart';
import 'package:book_search/init_dependencies.dart';

final booksProvider =
    StateNotifierProvider<BooksNotifier, AsyncValue<List<Book>>>((ref) {
      final booksRepository = BooksRepositoryImpl(
        dataSource: instance<BooksDatasource>(),
      );

      return BooksNotifier(booksRepository: booksRepository);
    });

class BooksNotifier extends StateNotifier<AsyncValue<List<Book>>> {
  final BooksRepository booksRepository;
  List<Book> _allBooksNew = [];
  Timer? _debounceTimer;

  BooksNotifier({required this.booksRepository})
    : super(const AsyncValue.loading()) {
    getBooks();
  }

  Future<void> getBooks() async {
    state = AsyncValue.loading();
    final Either<Failure, List<Book>> result = await booksRepository.getBooks();

    result.fold(
      (error) {
        state = AsyncValue.error(error.message, StackTrace.current);
      },
      (books) {
        _allBooksNew = books;
        state = AsyncValue.data(books);
      },
    );
  }

  Future<void> searchBook(String query) async {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isNotEmpty) {
        state = AsyncValue.loading();
        final Either<Failure, List<Book>> result = await booksRepository
            .searchBook(query);

        result.fold(
          (error) {
            state = AsyncValue.error(error.message, StackTrace.current);
          },
          (books) {
            state = AsyncValue.data(books);
          },
        );
      } else if (_allBooksNew.isEmpty) {
        getBooks();
      } else {
        state = AsyncValue.data(_allBooksNew);
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
