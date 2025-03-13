import 'package:akwe/src/constants/endpoint.dart';
import 'package:akwe/src/networking/base_service.dart';
import 'package:dio/dio.dart';

class AccountService{
  final BaseService _baseService = BaseService();

  Future<Response> get() async{
    return await _baseService.get("${Endpoint.ACCOUNTURL}/");
  }

  Future<Response> create(Map<String, dynamic> account) async{
    return await _baseService.post(
      Endpoint.ACCOUNTURL,
      data: account
    );
  }

  Future retrieve(String id) async{
    return await _baseService.get("${Endpoint.ACCOUNTURL}$id/");
  }

  Future<Response> update(dynamic account, String id) async{
    return await _baseService.put("${Endpoint.ACCOUNTURL}$id/", data: account);
  }

  Future delete(String id) async{
    return await _baseService.delete("${Endpoint.ACCOUNTURL}$id/");
  }


}