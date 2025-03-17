import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:either_dart/either.dart';

import 'package:book_search/config/network/failure.dart';
import 'package:book_search/features/books/domain/domain.dart';
import 'package:book_search/features/books/infrastructure/infrastructure.dart';
import 'package:book_search/init_dependencies.dart';

final bookDetailProvider = FutureProvider.autoDispose
    .family<BookDetails, String>((ref, isbn13) async {
      final booksRepository = BooksRepositoryImpl(
        dataSource: instance<BooksDatasource>(),
      );

      final Either<Failure, BookDetails> result = await booksRepository
          .getBookDetails(isbn13);

      return result.fold(
        (error) => throw Exception(error.message),
        (bookDetails) => bookDetails,
      );
    });
