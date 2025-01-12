

import 'package:akwe/src/constants/endpoint.dart';
import 'package:akwe/src/networking/base_service.dart';

class MetricService {
  final BaseService _baseService = BaseService();
  final baseUrl = Endpoint.METRICSURL;

  Future getExpenseByCategory({
    String? startDate = '',
    String? endDate = '',
  }) async {
    return await _baseService.get(
        "$baseUrl/expense/by-category/?start_date=$startDate&end_date=$endDate");
  }

  Future getIncomeByCategory({
    String? startDate = '',
    String? endDate = '',
  }) async {
    return await _baseService.get(
        "$baseUrl/income/by-category/?start_date=$startDate&end_date=$endDate");
  }

  Future getExpenseByAccount({
    String? startDate = '',
    String? endDate = '',
  }) async {
    return await _baseService.get(
        "$baseUrl/expense/by-account/?start_date=$startDate&end_date=$endDate");
  }

  Future getIncomeByAccount({
    String? startDate = '',
    String? endDate = '',
  }) async {
    return await _baseService.get(
        "$baseUrl/income/by-account/?start_date=$startDate&end_date=$endDate");
  }

  Future getExpenseByCompany({
    String? startDate = '',
    String? endDate = '',
  }) async {
    return await _baseService.get(
        "$baseUrl/expense/by-company/?start_date=$startDate&end_date=$endDate");
  }

  Future getExpensePerDay({
    String? startDate = '',
    String? endDate = '',
  }) async {
    return await _baseService.get(
        "$baseUrl/expense/per-day/?start_date=$startDate&end_date=$endDate");
  }

  Future getIncomePerDay({
    String? startDate = '',
    String? endDate = '',
  }) async {
    return await _baseService.get(
        "$baseUrl/income/per-day/?start_date=$startDate&end_date=$endDate");
  }

}
