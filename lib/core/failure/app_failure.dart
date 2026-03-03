import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

// Base Failure class
abstract class Failure extends Equatable {
  final String message;

  // You could add more properties like statusCode, stackTrace etc.

  const Failure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message; // Simple representation
}

// Specific Failure types (examples)
class ServerFailure extends Failure {
  const ServerFailure({String message = 'An API error occurred'})
    : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'Could not connect to the network'})
    : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Could not access local cache'})
    : super(message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String message = 'The requested item was not found'})
    : super(message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({String message = 'An unexpected error occurred'})
    : super(message);
}

class ApiFailure extends Failure {
  const ApiFailure({String message = 'An unexpected error occurred'})
    : super(message);
}

// Helper function to map exceptions to Failures (optional but useful)
Failure mapExceptionToFailure(dynamic e) {
  // Add more specific exception handling (e.g., for DioError, SocketException)
  if (e is FormatException) {
    return ServerFailure(message: "Bad response format from server");
  }

  if (e is SocketException) {
    return ServerFailure(message: "Network Error");
  }

  if (e is DioException) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.sendTimeout) {
      return NetworkFailure(message: "Network Error");
    }
    if (e.response?.data is Map<String, dynamic>) {
      dynamic message = e.response?.data['message'];
      if (message is List && message.isNotEmpty && message.first is String) {
        return mapMessageKeyFailure(message.first);
      } else if (message is String) {
        return mapMessageKeyFailure(message);
      }
    }
  }

  return UnexpectedFailure(message: "Error: $e");
}

Failure mapMessageKeyFailure(String? messageKey) {
  if (messageKey == null) return const UnexpectedFailure();
  switch (messageKey) {
    default:
      return UnexpectedFailure(message: messageKey);
  }
}
