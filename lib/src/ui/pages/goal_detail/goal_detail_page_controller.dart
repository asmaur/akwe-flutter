import 'package:akwe/src/models/goals/app_goal.dart';
import 'package:get/get.dart';

class GoalDetailPageController extends GetxController{

  var currentGoal = AppGoal().obs;

  @override
  void onInit() {
    currentGoal.value = Get.arguments;

    super.onInit();
  }


}