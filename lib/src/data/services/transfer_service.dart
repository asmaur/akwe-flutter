import 'package:akwe/src/constants/endpoint.dart';
import 'package:akwe/src/networking/base_service.dart';
import 'package:dio/dio.dart';

class TransferService{
  final BaseService _baseService = BaseService();

  Future<Response> list() async{
    return await _baseService.get(Endpoint.TRANSFERS);
  }

  Future<Response> create(Map<String, dynamic> transfer) async{
    return await _baseService.post(
        Endpoint.TRANSFERS,
        data: transfer
    );
  }

  Future retrieve(int id) async{
    return await _baseService.get("${Endpoint.TRANSFERS}$id/");
  }

  Future<Response> update(dynamic account, int id) async{
    return await _baseService.put("${Endpoint.TRANSFERS}$id/", data: account);
  }

  Future delete(int id) async{
    return await _baseService.delete("${Endpoint.TRANSFERS}$id/");
  }

  Future process(int id) async{
    return await _baseService.put("${Endpoint.TRANSFERS}/process/$id/");
  }


}