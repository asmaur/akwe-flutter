import 'package:akwe/src/ui/pages/planning_filter_result/planning_filter_result_page_controller.dart';
import 'package:get/get.dart';

class PlanningFilterResultPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PlanningFilterResultPageController());
  }

}