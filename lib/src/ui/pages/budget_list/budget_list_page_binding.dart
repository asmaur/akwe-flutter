import 'package:get/get.dart';

import 'budget_list_page_controller.dart';

class BudgetListPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BudgetListPageController());
  }

}