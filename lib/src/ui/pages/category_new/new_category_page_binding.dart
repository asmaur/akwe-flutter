import 'package:get/get.dart';

import 'new_category_page_controller.dart';

class NewCategoryPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NewCategoryPageController());
  }
}