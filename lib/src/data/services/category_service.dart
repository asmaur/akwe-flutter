import 'package:akwe/src/constants/endpoint.dart';
import 'package:akwe/src/networking/base_service.dart';
import 'package:dio/dio.dart';

class CategoryService{
  final BaseService _baseService = BaseService();

  Future<Response> get() async {
    return await _baseService.get(Endpoint.CATEGORYURL);
  }

  Future<Response> create(dynamic data) async{
    return await _baseService.post(Endpoint.CATEGORYURL, data: data);
  }

  Future<Response> update(String id, dynamic data) async{
    return await _baseService.put("${Endpoint.CATEGORYURL}$id/", data: data);
  }

  Future delete(String id) async{
    return await _baseService.delete("${Endpoint.CATEGORYURL}$id/");
  }

}