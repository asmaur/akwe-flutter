import 'package:get/get.dart';

import 'new_goal_page_controller.dart';

class NewGoalPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NewGoalPageController());
  }
}