import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

import 'package:dio/dio.dart';

import 'package:book_search/config/network/failure_mapper.dart';

void main() {
  group('FailureMapper Tests', () {
    test('Should return No internet connection for SocketException', () {
      final error = FailureMapper.mapException(
        SocketException("No connection"),
      );
      expect(
        error.message,
        "No internet connection. Please check your network.",
      );
    });

    test('Should return Data format error for FormatException', () {
      final error = FailureMapper.mapException(FormatException("Bad format"));
      expect(error.message, "Data format error.");
    });

    test('Should return Unexpected error for unknown exceptions', () {
      final error = FailureMapper.mapException(Exception("Unknown error"));
      expect(error.message, "An unexpected error occurred.");
    });

    test(
      'Should return The server took too long to respond for connection timeout',
      () {
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionTimeout,
        );
        final error = FailureMapper.mapException(dioError);
        expect(error.message, "The server took too long to respond.");
      },
    );

    test('Should return No data found for HTTP 404 error', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
        ),
        type: DioExceptionType.badResponse,
      );
      final error = FailureMapper.mapException(dioError);
      expect(error.message, "No data found.");
    });

    test('Should return Internal server error for HTTP 500 error', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
        type: DioExceptionType.badResponse,
      );
      final error = FailureMapper.mapException(dioError);
      expect(error.message, "Internal server error. Please try again later.");
    });

    test('Should return Bad request for HTTP 400 error', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 400,
        ),
        type: DioExceptionType.badResponse,
      );
      final error = FailureMapper.mapException(dioError);
      expect(error.message, "Bad request. Please check your input.");
    });
  });
}
