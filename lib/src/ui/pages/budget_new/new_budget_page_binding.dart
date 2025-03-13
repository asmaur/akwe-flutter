import 'package:get/get.dart';

import 'new_budget_page_controller.dart';

class NewBudgetPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NewBudgetPageController());
  }
}