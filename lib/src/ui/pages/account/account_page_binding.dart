import 'package:akwe/src/ui/pages/account/account_page_controller.dart';
import 'package:get/get.dart';

class AccountPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AccountPageController());
  }
}