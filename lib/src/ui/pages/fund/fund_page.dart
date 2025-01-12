import 'package:akwe/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';
import 'package:akwe/src/constants/app_colors.dart';

import 'fund_controller.dart';

class FundPage extends StatelessWidget {
  const FundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FundController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation.userFundTitleText.tr,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(translation.userFundNewFundText.tr),
        icon: const Icon(Icons.add),
        onPressed: () => {Get.toNamed(AppRoutes.NEWUSERACCOUNT)},
        tooltip: translation.userFundNewFundTooltipText.tr,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.appDarkGreen,
                ),
              )
            : controller.userFunds.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.userFunds.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(controller.userFunds[index].name!),
                        onTap: () {
                          Get.toNamed(AppRoutes.USERACCOUNTDETAIL,
                              arguments: controller.userFunds[index].id!);
                        },
                      );
                    },
                  )
                : Center(
                    child: SizedBox(
                      child: Text("No Fund found.",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
                      ),
                    ),
                  ),
      ),
    );
  }
}
