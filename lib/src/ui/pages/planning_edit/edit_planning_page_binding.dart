import 'package:get/get.dart';

import 'edit_planning_page_controller.dart';

class EditPlanningPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EditPlanningPageController());
  }
}