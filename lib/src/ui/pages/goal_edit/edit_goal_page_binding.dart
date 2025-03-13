import 'package:get/get.dart';

import 'edit_goal_page_controller.dart';

class EditGoalPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EditGoalPageController());
  }
}