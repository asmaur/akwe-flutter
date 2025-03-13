import 'package:akwe/src/ui/pages/planning_filter/planning_filter_page_controller.dart';
import 'package:get/get.dart';

class PlanningFilterPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PlanningFilterPageController());
  }

}