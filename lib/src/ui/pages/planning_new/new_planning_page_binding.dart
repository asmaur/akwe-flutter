import 'package:get/get.dart';

import 'new_planning_page_controller.dart';

class NewPlanningPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NewPlanningController());
  }
}