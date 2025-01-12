import 'package:get/get.dart';

import 'category_page_controller.dart';

class CategoryPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryPageController());
  }
}