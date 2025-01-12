import 'package:akwe/src/data/services/goal_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/goals/app_goal.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class GoalPageController extends GetxController{
  final GoalService _goalService = GoalService();
  // final premiumService = Get.find<AppPremiumService>();
  var activeUserGoals = <AppGoal>[].obs;
  var archivedUserGoals = <AppGoal>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    loadGoals();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  loadGoals() async {
    try {
      //var storeCategoryList = await _storageService.getCategoryList();
      List<dynamic> items;

      var response = await _goalService.list();

      if (response.statusCode == StatusCode.OK) {
        items = response.data;
        //print(items);
        //_storageService.setCategoryList(items);
      } else {
        items = []; //storeCategoryList;
      }

      if (items.isNotEmpty) {
        activeUserGoals.clear();
        archivedUserGoals.clear();
        for (var item in items) {
          if (item['active']==true) {
            activeUserGoals.add(AppGoal.fromJson(item));
          } else {
            archivedUserGoals.add(AppGoal.fromJson(item));
          }
        }
      }

      isLoading.value = false;
      update();
    } on dio.DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }


}