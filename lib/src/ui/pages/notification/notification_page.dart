import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_page_controller.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;


class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationPageController controller = Get.find<NotificationPageController>();
    //final _service = Get.find<NotificationService>();

    return Scaffold(
      appBar: AppBar(
        title: Text(translation.appNotificationPageTitle.tr),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            //_controller.getNotifications();
          }, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Text(translation.appNotificationPageNoNotification.tr),
      ),
    );
  }
}
