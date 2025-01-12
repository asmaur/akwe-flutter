import 'package:akwe/src/constants/endpoint.dart';
import 'package:akwe/src/networking/base_service.dart';
import 'package:dio/dio.dart';

class BudgetService{
  final BaseService _baseService = BaseService();
  final url = Endpoint.BUDGETURL;

  Future getMyBudget() async{
    return await _baseService.get("${url}my-budget/");
  }

  Future updateMyBudget(Map<String, dynamic> budget) async{
    //print("${url+budget['id']}/");
    return await _baseService.put("$url${budget['id']}/", data: budget);
  }

  Future getBudgetDetail(String id) async{
    return await _baseService.get("${Endpoint.BUDGETURL}$id/");
  }

  Future getBudgetList() async {
    return await _baseService.get(Endpoint.BUDGETURL);
    //"${Endpoint.BUDGETURL}?start_date=$startDate&end_date=$endDate");
  }

  Future getBudgetLast() async {
    return await _baseService.get("${Endpoint.BUDGETURL}last/");
    //"${Endpoint.BUDGETURL}?start_date=$startDate&end_date=$endDate");
  }

  Future<Response> filterBudget(String? startDate) async{
    return await _baseService.get("${Endpoint.BUDGETURL}filter/?start_date=$startDate");
  }

  destroy(String? id) async{
    return await _baseService.delete("${Endpoint.BUDGETURL}$id/");
  }

}