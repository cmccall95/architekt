import 'package:arkitekt/core/config/logger_custom.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/either.dart';
import 'env.dart';

part 'client_http.g.dart';

@riverpod
ClientHttp clientHttp(ClientHttpRef ref) {
  return ClientHttp();
}

class ClientHttp {
  ClientHttp() {
    _client = Dio(BaseOptions(
      baseUrl: Env.baseUrl,
    ));

    _client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          logger.d({
            'type': 'request',
            'url': options.uri,
            'method': options.method,
            'headers': options.headers,
            'queryParameters': options.queryParameters,
            'data': options.data,
          });

          return handler.next(options);
        },
        onResponse: (response, handler) async {
          logger.d({
            'type': 'response',
            'url': response.requestOptions.uri,
            'statusCode': response.statusCode,
            // 'data': response.data,
          });

          return handler.next(response);
        },
        onError: (e, handler) async {
          logger.d({
            'type': 'error',
            'url': e.requestOptions.uri,
            'statusCode': e.response?.statusCode,
            'data': e.response?.data,
          });

          return handler.next(e);
        },
      ),
    );
  }

  late final Dio _client;

  Future<Either<ResponseError, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _client.get(
        path,
        queryParameters: queryParameters,
      );

      return Right(response.data);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<ResponseError, dynamic>> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _client.post(
        path,
        queryParameters: queryParameters,
        data: data,
      );

      return Right(response.data);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<ResponseError, dynamic>> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _client.put(
        path,
        queryParameters: queryParameters,
        data: data,
      );

      return Right(response.data);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<ResponseError, dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _client.delete(
        path,
        queryParameters: queryParameters,
      );

      return Right(response.data);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  ResponseError _handleError(dynamic e) {
    if (e is! DioException) {
      return ResponseError(
        message: e.toString(),
        statusCode: 500,
      );
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ResponseError(
          message: e.message ?? 'Timeout',
          statusCode: 408,
        );
      case DioExceptionType.badResponse:
        String message = e.message ?? 'Bad response';
        if (e.response?.data is Map) {
          message = e.response!.data['message'] ?? message;
        }

        return ResponseError(
          message: message,
          statusCode: e.response?.statusCode ?? 500,
        );
      default:
        return ResponseError(
          message: e.message ?? 'Unknown error',
          statusCode: 500,
        );
    }
  }
}

class ResponseError {
  ResponseError({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;
}
