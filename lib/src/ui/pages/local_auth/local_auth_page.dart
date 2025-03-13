import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poupey/src/constants/app_colors.dart';
import 'package:poupey/src/constants/app_layout.dart';
import 'package:poupey/src/pages/local_auth/local_auth_controller.dart';
import 'package:poupey/src/translations/translation_keys.dart' as translation;


class LocalAuthPage extends StatelessWidget {
  const LocalAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocalAuthController>();

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(translation.appLocalAuthTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          margin: EdgeInsets.only(left: AppLayout.getHeight(10), right: AppLayout.getHeight(10)),
          child: Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(AppLayout.getHeight(50)),
                  backgroundColor: AppColors.appDarkGreen,),
              icon: const Icon(
                Icons.lock_open,
                color: Colors.white,
              ),
              label: Text(
                translation.appLocalAuthUnlockText.tr,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
              ),
              onPressed: () {
                controller.authenticate();
              },
            ),
          ),
        ),
      ),
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(translation.appLocalAuthDialogTitle.tr),
              content: Text(translation.appLocalAuthDialogContent.tr),
              actions: [
                // TextButton(
                //   onPressed: () {
                //     //Navigator.pop(context, true);
                //     SystemNavigator.pop();
                //   },
                //   child: const Text('Yes'),
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'Okay',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
    );
  }
}
