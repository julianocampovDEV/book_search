import 'package:either_dart/either.dart';

import 'package:book_search/config/network/failure.dart';
import 'package:book_search/features/books/domain/domain.dart';

class BooksRepositoryImpl extends BooksRepository {
  final BooksDatasource dataSource;

  BooksRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    return await dataSource.getBooks();
  }

  @override
  Future<Either<Failure, List<Book>>> searchBook(String query) async {
    return await dataSource.searchBook(query);
  }

  @override
  Future<Either<Failure, BookDetails>> getBookDetails(String isbn13) async {
    return await dataSource.getBookDetails(isbn13);
  }
}
