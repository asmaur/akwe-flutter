import 'package:get/get.dart';

import 'goal_detail_page_controller.dart';

class GoalDetailPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => GoalDetailPageController());
  }
}