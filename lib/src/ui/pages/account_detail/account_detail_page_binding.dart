import 'package:get/get.dart';

import 'account_detail_page_controller.dart';


class AccountDetailPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AccountDetailPageController());
  }
}