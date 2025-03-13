import 'package:get/get.dart';

import 'goal_deposit_page_controller.dart';

class GoalDepositPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => GoalDepositPageController());
  }
}