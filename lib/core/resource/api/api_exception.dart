import 'dart:io';

import "package:dio/dio.dart" show DioException, DioExceptionType, Response;

class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException({required this.message, this.code});

  @override
  String toString() {
    return 'ApiException: $message (code: $code)';
  }

  static ApiException fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: "Connection timeout. Please try again.",
          code: dioException.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        return _handleHttpResponse(dioException.response);
      case DioExceptionType.cancel:
        return ApiException(
          message: "Request to API server was cancelled",
          code: dioException.response?.statusCode,
        );
      case DioExceptionType.unknown:
        if (dioException.error is SocketException) {
          return ApiException(
            message: "No Internet connection. Please check your connection.",
            code: dioException.response?.statusCode,
          );
        }
        return ApiException(
          message: "Unexpected error occurred",
          code: dioException.response?.statusCode,
        );
      default:
        return ApiException(
          message: "Unexpected error occurred",
          code: dioException.response?.statusCode,
        );
    }
  }

  static ApiException _handleHttpResponse(Response? response) {
    final statusCode = response?.statusCode;
    final errorMessage = response?.data['message'] ?? "Unknown error";

    switch (statusCode) {
      case 400:
        return ApiException(
            message: "Bad request: $errorMessage", code: statusCode);
      case 401:
        return ApiException(
            message: "Unauthorized: $errorMessage", code: statusCode);
      case 403:
        return ApiException(
            message: "Forbidden: $errorMessage", code: statusCode);
      case 404:
        return ApiException(
            message: "Not found: $errorMessage", code: statusCode);
      case 500:
        return ApiException(
            message: "Internal server error: $errorMessage", code: statusCode);
      case 502:
        return ApiException(
            message: "Bad gateway: $errorMessage", code: statusCode);
      case 503:
        return ApiException(
            message: "Service unavailable: $errorMessage", code: statusCode);
      case 504:
        return ApiException(
            message: "Gateway timeout: $errorMessage", code: statusCode);
      default:
        return ApiException(
          message: "Received invalid status code: $statusCode",
          code: statusCode,
        );
    }
  }
}
