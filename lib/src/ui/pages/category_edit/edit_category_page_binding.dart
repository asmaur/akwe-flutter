import 'package:get/get.dart';

import 'edit_category_page_controller.dart';

class EditCategoryPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EditCategoryPageController());
  }
}