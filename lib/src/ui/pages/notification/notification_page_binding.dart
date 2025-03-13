import 'package:get/get.dart';

import 'notification_page_controller.dart';

class NotificationPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationPageController());
  }
}