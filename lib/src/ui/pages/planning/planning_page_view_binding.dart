import 'package:akwe/src/ui/pages/planning/planning_page_view_controller.dart';
import 'package:get/get.dart';

class PlanningPageViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PlanningPageViewController());
  }
}