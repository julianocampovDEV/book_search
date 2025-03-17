import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import 'package:book_search/config/network/failure_mapper.dart';
import 'package:book_search/config/network/failure.dart';
import 'package:book_search/features/books/domain/domain.dart';
import 'package:book_search/features/books/infrastructure/infrastructure.dart';
import 'package:book_search/shared/data/models/models.dart';
import 'package:book_search/shared/services/api_service.dart';

class BooksDatasourceImpl extends BooksDatasource {
  final ApiService _apiService;

  BooksDatasourceImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    try {
      const String url = Endpoints.news;
      final Response response = await _apiService.get(url: url);

      final List<Book> books =
          (response.data['books'] as List)
              .map((book) => BookMapper.jsonToEntity(book))
              .toList();
      return Right(books);
    } catch (error) {
      return Left(FailureMapper.mapException(error));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> searchBook(String query) async {
    try {
      String url = "${Endpoints.search}/$query";
      final Response response = await _apiService.get(url: url);

      final List<Book> books =
          (response.data['books'] as List)
              .map((book) => BookMapper.jsonToEntity(book))
              .toList();
      return Right(books);
    } catch (error) {
      return Left(FailureMapper.mapException(error));
    }
  }

  @override
  Future<Either<Failure, BookDetails>> getBookDetails(String isbn13) async {
    try {
      String url = "${Endpoints.books}/$isbn13";
      final Response response = await _apiService.get(url: url);
      final BookDetails bookDetails = BookDetailsMapper.jsonToEntity(
        response.data,
      );

      return Right(bookDetails);
    } catch (error) {
      return Left(FailureMapper.mapException(error));
    }
  }
}
