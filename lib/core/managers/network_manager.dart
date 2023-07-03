import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/env/env.dart';
import 'package:todo_list_app/core/error/exceptions.dart';
import 'package:todo_list_app/core/managers/persistence_manager.dart';

class NetworkManager {
  static const timeoutTime = 5;

  Dio? _dio;

  final PersistenceManager _persistenceManager;

  NetworkManager({required persistenceManager}) : _persistenceManager = persistenceManager;

  Dio get dioInstance {
    _dio ??= Dio(BaseOptions(
        baseUrl: Env.tasksHost,
        connectTimeout: const Duration(seconds: timeoutTime),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Env.token
        }))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            options.headers['X-Last-Known-Revision'] =
                await _persistenceManager.getTasksRevision();
            handler.next(options);
          },
        ),
      );
    return _dio!;
  }

  Future<Response> get(String path) async {
    return _request(() => dioInstance.get(path));
  }

  Future<Response> post(String path, Map<String, dynamic> data) async {
    return _request(() => dioInstance.post(path, data: data));
  }

  Future<Response> delete(String path) async {
    return _request(() => dioInstance.delete(path));
  }

  Future<Response> put(String path, Map<String, dynamic> data) async {
    return _request<Response>(() => dioInstance.put(path, data: data));
  }

  Future<Response> patch(String path, Map<String, dynamic> data) async {
    return _request<Response>(() => dioInstance.patch(path, data: data));
  }

  Future<T> _request<T>(Future<T> Function() requestFunc) async {
    try {
      return await requestFunc();
    } on DioException catch (dioException) {
      switch (dioException.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.cancel:
        case DioExceptionType.connectionError:
          throw NoInternetException();
        case DioExceptionType.badResponse:
          throw ResponseException('Bad response');
        default:
          if (dioException.error is SocketException) {
            throw NoInternetException();
          } else {
            throw UnknownNetworkException();
          }
      }
    } on SocketException catch (_) {
      throw NoInternetException();
    } on Object catch (_) {
      throw UnknownNetworkException();
    }
  }
}
