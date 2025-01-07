import 'package:akwe/src/ui/pages/account/account_page_view_controller.dart';
import 'package:get/get.dart';

class AccountPageViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AccountPageViewController());
  }
}