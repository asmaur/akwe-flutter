import 'package:get/get.dart';

import 'category_page_view_controller.dart';

class CategoryPageViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryPageViewController());
  }
}