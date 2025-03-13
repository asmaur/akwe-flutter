import 'package:get/get.dart';

import 'budget_all_page_controller.dart';

class BudgetAllPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BudgetAllPageController());
  }

}