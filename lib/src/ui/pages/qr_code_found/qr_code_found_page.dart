import 'package:akwe/src/ui/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class QrCodeFoundPage extends StatelessWidget {
  const QrCodeFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            translation.appQrCodeCreateNewTransactionLabel.tr,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),

      ),
      drawer: AppDrawerMobile(),
    );
  }
}
