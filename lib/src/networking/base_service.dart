import 'package:dio/dio.dart';
import "package:akwe/src/config/config.dart";
import "package:akwe/src/constants/endpoint.dart";

import 'app_interceptor.dart';
import 'logger_interceptor.dart';

class BaseService {
  late final Dio _dio;

  BaseService() {
    _dio = Dio(_options);

    _dio.interceptors.addAll([AppInterceptor(), LoggerInterceptor()]);
    // _dio = Dio(BaseOptions(responseType: ResponseType.json))
    //   ..interceptors.addAll([LoggerInterceptor()]);
  }

  static final _options = BaseOptions(
    baseUrl: Config.DEBUG ? Endpoint.BASEURLDEV : Endpoint.BASEURL,
    connectTimeout: const Duration(milliseconds: Config.CONNECTIONTIMEOUT),
    receiveTimeout: const Duration(milliseconds: Config.RCEIVEDTIMEOUT),
    responseType: ResponseType.json,
  );

  Future<Response> get(
    String url, {
    Map<String, String>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    data,
    Map<String, String>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    data,
    Map<String, String>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String url, {
    Map<String, String>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
