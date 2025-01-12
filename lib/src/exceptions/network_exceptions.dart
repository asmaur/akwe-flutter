import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;


class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = translation.appNetworkErrorCancel.tr;
        break;
      case DioExceptionType.connectionTimeout:
        message = translation.appNetworkErrorConnectionTimeout.tr;
        break;
      case DioExceptionType.receiveTimeout:
        message = translation.appNetworkErrorReceiveTimeout.tr;
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = translation.appNetworkErrorSendTimeout.tr;
        break;
      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
          message = translation.appNetworkErrorNoInternetConnection.tr;
          break;
        }
        message = translation.appNetworkErrorUnknown.tr;
        break;
      default:
        message = translation.appNetworkErrorUnknown.tr;
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return translation.appNetworkError400.tr;
      case 401:
        return translation.appNetworkError401.tr;
      case 403:
        return translation.appNetworkError403.tr;
      case 404:
        return translation.appNetworkError404.tr;
      case 500:
        return translation.appNetworkError500.tr;
      case 502:
        return translation.appNetworkError502.tr;
      default:
        return translation.appNetworkErrorDefault.tr;
    }
  }

  @override
  String toString() => message;
}
