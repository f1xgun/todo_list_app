import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/core/utils/managers/persistence_manager.dart';

class NetworkManager {
  static const url = 'https://beta.mrdekk.ru/todobackend';
  static const timeoutTime = 5;

  Dio? _dio;

  Dio get dioInstance {
    _dio ??= Dio(BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(seconds: timeoutTime),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer balladwise'
        }))
      ..interceptors.add(ErrorInterceptor())
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            options.headers['X-Last-Known-Revision'] =
                await PersistenceManager().getTasksRevision();
            handler.next(options);
          },
        ),
      );
    return _dio!;
  }

  NetworkManager();

  Future<Response> get(String path) async {
    try {
      final response = await dioInstance.get(path);
      return response;
    } on Exception catch (_) {
      return Response(
        statusCode: 500,
        statusMessage: 'Server error',
        requestOptions: RequestOptions(),
      );
    }
    // final response = await dioInstance.get(path).timeout(
    //       const Duration(seconds: timeoutTime),
    //     );
    // return response;
  }

  Future<Response> post(String path, Map<String, dynamic> data) async {
    try {
      final response = await dioInstance.post(path, data: data);
      return response;
    } on Exception catch (_) {
      return Response(
        statusCode: 500,
        statusMessage: 'Server error',
        requestOptions: RequestOptions(),
      );
    }
    final response = await dioInstance.post(path, data: data).timeout(
          const Duration(seconds: timeoutTime),
        );
    return response;
  }

  Future<Response> delete(String path) async {
    final response = await dioInstance.delete(path).timeout(
          const Duration(seconds: timeoutTime),
        );
    return response;
  }

  Future<Response> put(String path, Map<String, dynamic> data) async {
    try {
      final response = await dioInstance.put(path, data: data);
      return response;
    } on Exception catch (_) {
      return Response(
        statusCode: 500,
        statusMessage: 'Server error',
        requestOptions: RequestOptions(),
      );
    }
    final response = await dioInstance.put(path, data: data).timeout(
          const Duration(seconds: timeoutTime),
        );
    return response;
  }

  Future<Response> patch(String path, Map<String, dynamic> data) async {
    try {
      final response = await dioInstance.patch(path, data: data);
      return response;
    } on Exception catch (_) {
      return Response(
        statusCode: 500,
        statusMessage: 'Server error',
        requestOptions: RequestOptions(),
      );
    }
    final response = await dioInstance.patch(path, data: data).timeout(
          const Duration(seconds: timeoutTime),
        );
    return response;
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error is SocketException) {
      final socketException = err.error as SocketException;
      logger.info('Request error: ${socketException.message}');
      throw Exception(err.message);
    } else if (err.error is DioException) {
      final dioError = err.error as DioException;
      logger.info('Request error: $dioError');
      throw Exception('${dioError.message}');
    } else if (err.error is TimeoutException) {
      final timeoutException = err.error as TimeoutException;
      logger.info('Request error: ${timeoutException.message}');
      throw Exception('${timeoutException.message}');
    } else {
      logger.info('Request error: ${err.error}');
      throw Exception('${err.error}');
    }
  }
}
