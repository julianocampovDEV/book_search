import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

import 'package:book_search/config/network/failure.dart';
import 'package:book_search/features/books/infrastructure/infrastructure.dart';
import 'package:book_search/shared/data/models/models.dart';
import 'package:book_search/shared/services/api_service.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late BooksDatasourceImpl datasource;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    datasource = BooksDatasourceImpl(apiService: mockApiService);
  });

  group('BooksDatasourceImpl Tests', () {
    test(
      'Should return a list of books when getBooks() is successful',
      () async {
        final mockResponse = {
          "books": [
            {
              "title": "Book 1",
              "subtitle": "Subtitle 1",
              "isbn13": "123456789",
              "price": "\$10",
              "image": "url",
              "url": "url",
              "pdf": null,
            },
            {
              "title": "Book 2",
              "subtitle": "Subtitle 2",
              "isbn13": "987654321",
              "price": "\$20",
              "image": "url",
              "url": "url",
            },
          ],
        };

        when(() => mockApiService.get(url: Endpoints.news)).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: Endpoints.news),
            data: mockResponse,
            statusCode: 200,
          ),
        );

        final result = await datasource.getBooks();

        expect(result.isRight, isTrue);
        expect(result.right.length, 2);
      },
    );

    test('Should return a Failure when getBooks() fails', () async {
      when(() => mockApiService.get(url: Endpoints.news)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: Endpoints.news),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: Endpoints.news),
            statusCode: 500,
          ),
        ),
      );

      final result = await datasource.getBooks();

      expect(result.isLeft, isTrue);
      expect(result.left, isA<Failure>());
      expect(
        result.left.message,
        "Internal server error. Please try again later.",
      );
    });

    test(
      'Should return a list of books when searchBook() is successful',
      () async {
        final query = "flutter";
        final mockResponse = {
          "books": [
            {
              "title": "Title 1",
              "subtitle": "Subtitle 1",
              "isbn13": "11111111",
              "price": "\$10",
              "image": "url",
              "url": "url",
            },
          ],
        };

        when(
          () => mockApiService.get(url: "${Endpoints.search}/$query"),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: "${Endpoints.search}/$query"),
            data: mockResponse,
            statusCode: 200,
          ),
        );

        final result = await datasource.searchBook(query);

        expect(result.isRight, isTrue);
        expect(result.right.first.title, "Title 1");
      },
    );

    test('Should return a Failure when searchBook() fails', () async {
      final query = "test";

      when(
        () => mockApiService.get(url: "${Endpoints.search}/$query"),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: "${Endpoints.search}/$query"),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final result = await datasource.searchBook(query);

      expect(result.isLeft, isTrue);
      expect(result.left, isA<Failure>());
      expect(result.left.message, "The server took too long to respond.");
    });

    test(
      'Should return book details when getBookDetails() is successful',
      () async {
        final isbn13 = "123456789";
        final mockResponse = {
          "title": "Title 1",
          "subtitle": "Subtitle 1",
          "isbn13": "123456789",
          "price": "\$10",
          "image": "url",
          "url": "url",
        };

        when(
          () => mockApiService.get(url: "${Endpoints.books}/$isbn13"),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: "${Endpoints.books}/$isbn13"),
            data: mockResponse,
            statusCode: 200,
          ),
        );

        final result = await datasource.getBookDetails(isbn13);

        expect(result.isRight, isTrue);
        expect(result.right.title, "Title 1");
      },
    );

    test('Should return a Failure when getBookDetails() fails', () async {
      final isbn13 = "123456789";

      when(
        () => mockApiService.get(url: "${Endpoints.books}/$isbn13"),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: "${Endpoints.books}/$isbn13"),
          type: DioExceptionType.receiveTimeout,
        ),
      );

      final result = await datasource.getBookDetails(isbn13);

      expect(result.isLeft, isTrue);
      expect(result.left, isA<Failure>());
      expect(result.left.message, "Timeout while receiving data.");
    });
  });
}
