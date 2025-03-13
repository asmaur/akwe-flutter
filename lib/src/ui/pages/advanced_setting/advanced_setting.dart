import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poupey/src/constants/app_colors.dart';
import 'package:poupey/src/constants/app_layout.dart';
import 'package:poupey/src/translations/translation_keys.dart' as translation;
import 'advanced_setting_controller.dart';

class AdvancedSetting extends StatelessWidget {
  const AdvancedSetting({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(AdvancedSettingController());

    return Scaffold(
      appBar: AppBar(
        title: Text(translation.appAdvancedSettingTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),),
      ),
      body: Column(
        children: [
          SizedBox(
            height: AppLayout.getHeight(20),
          ),
          Center(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                      //leading: Icon(Icons.album),
                      //title: Text('Recomençar do zero'),
                      subtitle: Column(
                    children: [
                      Text(
                        translation.appAdvancedSettingFromScratch.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 18),
                      ),
                      Divider(
                        height: AppLayout.getHeight(5),
                      ),
                      SizedBox(height: AppLayout.getHeight(10),),
                      Text(translation.appAdvancedSettingProcessIntent.tr),
                      ListTile(
                          leading: const Icon(Icons.do_not_disturb_on_total_silence),
                          title: Text(translation.appAdvancedSettingDeleteTransaction.tr)),
                      ListTile(
                        leading: const Icon(Icons.do_not_disturb_on_total_silence),
                        title: Text(translation.appAdvancedSettingDeleteAccount.tr),
                      ),
                      ListTile(
                        leading: const Icon(Icons.do_not_disturb_on_total_silence),
                        title: Text(
                          translation.appAdvancedSettingDeletePlanning.tr,),
                      ),
                      ListTile(
                        leading: const Icon(Icons.do_not_disturb_on_total_silence),
                        title: Text(translation.appAdvancedSettingDeleteHistoric.tr),
                      ),

                    ],
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      OutlinedButton(
                        onPressed: () {
                          controller.resetDataAction();
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.appRed,
                            side: const BorderSide(color: Colors.transparent)),
                        child: Text(translation.appAdvancedSettingResetButtonText.tr,),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
