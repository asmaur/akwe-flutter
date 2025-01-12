import 'package:akwe/src/data/services/planning_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/routines/routine.dart';
import 'package:akwe/src/ui/shared/date_utils.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class PlanningPageController extends GetxController{
  var todayRoutines = <Routine>[].obs;
  var weekRoutines = <Routine>[].obs;
  var routines = <Routine>[].obs;
  final PlanningService _planningService = PlanningService();

  @override
  void onInit() {
    getCurrentMonthRoutine();
    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getCurrentMonthRoutine() async {

    List<dynamic> items;

    try {
      dio.Response response =
      await _planningService.getAllCurrentMonthRoutine();


      items = response.data;
      routines.clear();
      todayRoutines.clear();
      weekRoutines.clear();

      // Routine value;
      for (var item in items) {
        var value = Routine.fromJson(item);
        if (AppDateUtils().isToday(value.expirationDate!))
        {todayRoutines.add(value);}
        if (AppDateUtils().isDateInWeek(value.expirationDate!))
        {weekRoutines.add(value);}
        routines.add(value);
      }

    } on dio.DioException catch(e){
      //log(stack);
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }

  refreshCurrentMonthRoutine() async {

    List<dynamic> items;
    try {
      dio.Response response =
      await _planningService.getAllCurrentMonthRoutine();

      items = response.data;

      routines.clear();
      todayRoutines.clear();
      weekRoutines.clear();

      // Routine value;
      for (var item in items) {
        var value = Routine.fromJson(item);
        if (AppDateUtils().isToday(value.expirationDate!))
        {todayRoutines.add(value);}
        if (AppDateUtils().isDateInWeek(value.expirationDate!))
        {weekRoutines.add(value);}
        routines.add(value);
      }

    } on dio.DioException catch(e){
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }

  shortRoutineDetail(){
    DialogHelper.showErrorDialog();
  }


}