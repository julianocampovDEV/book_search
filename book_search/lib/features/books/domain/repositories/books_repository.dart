import 'package:either_dart/either.dart';

import 'package:book_search/config/network/failure.dart';
import 'package:book_search/features/books/domain/domain.dart';

abstract class BooksRepository {
  Future<Either<Failure, List<Book>>> getBooks();
  Future<Either<Failure, List<Book>>> searchBook(String query);
  Future<Either<Failure, BookDetails>> getBookDetails(String isbn13);
}
