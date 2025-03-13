import 'package:get/get.dart';
import 'planning_detail_page_controller.dart';

class PlanningDetailPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PlanningDetailPageController());
  }
}