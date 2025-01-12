import 'package:akwe/src/ui/pages/planning/planning_page_controller.dart';
import 'package:get/get.dart';

class PlanningPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PlanningPageController());
  }
}