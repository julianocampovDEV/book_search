import 'dart:io';

import 'package:dio/dio.dart';

import 'package:book_search/config/network/failure.dart';

class FailureMapper {
  static Failure mapException(dynamic error) {
    if (error is DioException) {
      return _mapDioException(error);
    } else if (error is SocketException) {
      return Failure(
        message: "No internet connection. Please check your network.",
      );
    } else if (error is FormatException) {
      return Failure(message: "Data format error.");
    } else {
      return Failure(message: "An unexpected error occurred.");
    }
  }

  static Failure _mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(message: "The server took too long to respond.");
      case DioExceptionType.sendTimeout:
        return Failure(message: "Timeout while sending data.");
      case DioExceptionType.receiveTimeout:
        return Failure(message: "Timeout while receiving data.");
      case DioExceptionType.badResponse:
        return Failure(message: _handleHttpError(error.response?.statusCode));
      case DioExceptionType.cancel:
        return Failure(message: "The request was canceled.");
      default:
        return Failure(message: "Connection error with the server.");
    }
  }

  static String _handleHttpError(int? statusCode) {
    if (statusCode == null) return "Unknown server error.";
    switch (statusCode) {
      case 400:
        return "Bad request. Please check your input.";
      case 401:
        return "Unauthorized access.";
      case 403:
        return "Access forbidden.";
      case 404:
        return "No data found.";
      case 500:
        return "Internal server error. Please try again later.";
      default:
        return "Unexpected error ($statusCode).";
    }
  }
}
