import 'package:get/get.dart';

import 'budget_full_page_controller.dart';

class BudgetFullPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BudgetFullPageController());
  }

}