import 'package:akwe/src/constants/endpoint.dart';
import 'package:akwe/src/networking/base_service.dart';
import 'package:dio/dio.dart';

class GoalService{
  final BaseService _baseService = BaseService();


  Future<Response> list() async{
    return await _baseService.get(Endpoint.GOALURL);
  }

  Future<Response> create(dynamic data) async{
    return await _baseService.post(Endpoint.GOALURL, data: data);
  }

  Future<Response> retrieve(String id) async {
    return await _baseService.get("${Endpoint.GOALURL}$id/");
  }

  Future<Response> delete(String id) async{
    return await _baseService.delete("${Endpoint.GOALURL}$id/");
  }

  Future<Response> update(String id, dynamic data) async{
    return await _baseService.put("${Endpoint.GOALURL}$id/", data: data);
  }

  Future<Response> archive(String id) async{
    return await _baseService.delete("${Endpoint.GOALURL}/archive/$id/");
  }

  Future<Response> deposit(data) async{
    return await _baseService.put("${Endpoint.TRANSACTIONURL}deposit/", data: data);
  }

}