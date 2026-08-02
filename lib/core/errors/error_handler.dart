import 'package:dio/dio.dart';

class ErrorHandler {
  static String getMessage(Object? error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timed out. Please try again.";

        case DioExceptionType.sendTimeout:
          return "Request timed out. Please try again.";

        case DioExceptionType.receiveTimeout:
          return "Server took too long to respond.";

        case DioExceptionType.badCertificate:
          return "Secure connection failed.";

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;

          switch (statusCode) {
            case 400:
              return "Invalid request.";

            case 401:
              return "Please log in again.";

            case 403:
              return "You don't have permission.";

            case 404:
              return "The requested information could not be found.";

            case 500:
              return "Server error. Please try again later.";

            case 502:
            case 503:
            case 504:
              return "Service is temporarily unavailable.";

            default:
              return "Something went wrong. Please try again.";
          }

        case DioExceptionType.cancel:
          return "Request cancelled.";

        case DioExceptionType.connectionError:
          return "No internet connection.";

        case DioExceptionType.unknown:
          return "Something went wrong. Please try again.";

        case DioExceptionType.transformTimeout:
          return "The server response took too long.";

        default:
          return "An unexpected error occurred.";
      }
    }

    return "Something went wrong. Please try again.";
  }
}