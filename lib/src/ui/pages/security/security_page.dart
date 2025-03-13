import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poupey/src/pages/security/security_controller.dart';
import 'package:poupey/src/translations/translation_keys.dart' as translation;


class SecuritySetting extends StatelessWidget {
  const SecuritySetting({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<SecurityController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(translation.appSecurityTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // ListTile(
            //   onTap: (){},
            //   title: Text("Password"),
            //   subtitle: Text("Pedir senha ao abrir o app (alfa)"),
            // ),
            Obx(() => ListTile(
              onTap: (){
                controller.enableBiometricsAuth();
                controller.enableBiometrics.value = !controller.enableBiometrics.value;
                // _controller.enableBiometricsAuth();
              },
              title: Text(translation.appSecurityLockAppTitle.tr),
              subtitle: Text(translation.appSecurityLockAppSubtitle.tr),
              trailing: Switch(
                onChanged: (bool? value) {
                  controller.enableBiometrics.value = !controller.enableBiometrics.value;
                  controller.enableBiometricsAuth();
                },
                value: controller.enableBiometrics.value,
              ),
            ),),

            const Divider(),

            // ListTile(
            //   onTap: (){},
            //   title: Text("Lock with a PIN"),
            //   subtitle: Text("Require PIN on start (alfa)"),
            //   trailing: Switch(
            //     onChanged: (bool? value) {
            //       _controller.enablePinCode.value = !_controller.enablePinCode.value;
            //       _controller.enablePinCodeAuth();
            //     },
            //     value: _controller.enablePinCode.value,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
