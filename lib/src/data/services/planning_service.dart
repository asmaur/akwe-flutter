
import 'package:akwe/src/constants/endpoint.dart';
import 'package:akwe/src/networking/base_service.dart';
import 'package:dio/dio.dart';

class PlanningService{
  final BaseService _baseService = BaseService();


  Future<Response> getAllCurrentMonthRoutine() async{
      return await _baseService.get(Endpoint.ROUTINES);
  }

  getAllPeriodicRoutine(DateTime initDate, DateTime finalDate){
    print("object");
  }

  Future<Response> createNewPlanning(dynamic routine){
    return _baseService.post(Endpoint.ROUTINES, data: routine);
  }

  Future updateRoutine(int id, dynamic routine){
    return _baseService.put("${Endpoint.ROUTINES}$id/", data: routine);
  }

  Future destroyRoutine(int id){
    return _baseService.delete("${Endpoint.ROUTINES}$id/");
  }

  Future<Response> getFilterRoutine(String? initialDate, String? finalDate,) async {
    return await _baseService.get(
      "${Endpoint.ROUTINES}filter/?start_date=$initialDate&end_date=$finalDate",
    );
  }

  addToCalendar(int? id) async{
    return _baseService.put("${Endpoint.ROUTINES}$id/");
  }

}