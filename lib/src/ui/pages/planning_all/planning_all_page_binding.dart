import 'package:akwe/src/ui/pages/planning_all/planning_all_page_controller.dart';
import 'package:get/get.dart';

class PlanningAllPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PlanningAllPageController());
  }

}