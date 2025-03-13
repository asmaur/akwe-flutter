//* Request methods PUT, POST, PATCH, DELETE needs access token,
//* which needs to be passed with "Authorization" header as Bearer token.
import 'package:dio/dio.dart';

import '../data/storage/storage_service.dart';
import '../globals/app_authentication_service.dart';

class AppInterceptor extends Interceptor {
  final _storage = StorageService();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    try {
      final String? token = await _storage.get("token");
      options.headers["Authorization"] = "Bearer $token";
      // options.headers['Content-type'] = 'application/json';
      // options.headers['Accept'] = 'application/json';
      // handler.next(options);
      super.onRequest(options, handler);
    } on Exception catch(e){
      print(e);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      await AppAuthenticationService().refreshToken();
      final token = await _storage.get("token");
      // Update the request header with the new access token
      // err.requestOptions.headers['Authorization'] = 'Bearer $token';

      // Repeat the request with the updated header
      // final dio = Dio();
      // handler.resolve(await dio.fetch(err.requestOptions));
    }
    super.onError(err, handler);
  }
}