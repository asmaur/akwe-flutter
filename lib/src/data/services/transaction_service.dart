import 'package:akwe/src/constants/endpoint.dart';
import 'package:akwe/src/networking/base_service.dart';
import 'package:dio/dio.dart';

class TransactionService {
  final BaseService _baseService = BaseService();

  Future<Response> getCurrentMonthTransaction() async {
    return await _baseService.get(Endpoint.TRANSACTIONURL);
  }

  Future<Response> getPeriodicTransaction(
      String? initialDate, String? finalDate) async {
    return await _baseService.get(Endpoint.TRANSACTIONURL);
  }

  Future<Response> retrieve(String id) async{
    return await _baseService.get("${Endpoint.TRANSACTIONURL}$id");
  }

  Future<Response> createGenericTransaction(Map<String, dynamic> data) async {
    return await _baseService.post(Endpoint.TRANSACTIONURL, data: data);
  }

  Future<Response> createInvoiceTransaction(Map<String, dynamic> data) async {
    return await _baseService.post("${Endpoint.TRANSACTIONURL}invoices/",
        data: data);
  }

  Future<Response> updateTransaction(Map<String, dynamic> data, String id) async {
    return await _baseService.put("${Endpoint.TRANSACTIONURL}/invoices/$id/",
        data: data);
  }

  Future<Response> getTransactionItems(String id) async {
    return await _baseService.get("${Endpoint.TRANSACTIONURL}/items/$id/");
  }

  Future<Response> executeNewRoutine(Map<String, dynamic> data) async {
    return await _baseService.post("${Endpoint.TRANSACTIONURL}/routines/",
        data: data);
  }

  Future<Response> getFilterTransaction(
      String? initialDate, String? finalDate) async {
    return await _baseService.get(
      "${Endpoint.TRANSACTIONURL}filter/?start_date=$initialDate&end_date=$finalDate",
    );
  }

  Future<Response> destroy(String id) async{
    return await _baseService.delete("${Endpoint.TRANSACTIONURL}$id/");
  }

  Future<Response> update(String id, dynamic data) async{
    return await _baseService.put("${Endpoint.TRANSACTIONURL}$id/", data: data,);
  }

}
