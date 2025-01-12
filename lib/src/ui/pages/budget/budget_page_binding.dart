import 'package:akwe/src/ui/pages/budget/budget_page.dart';
import 'package:akwe/src/ui/pages/budget/budget_page_controller.dart';
import 'package:get/get.dart';

class BudgetPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BudgetPageController());
  }
}