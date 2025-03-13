import 'dart:io';

import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

import 'budget_all_page_controller.dart';

class BudgetAllPage extends StatelessWidget {
  BudgetAllPage({super.key});
  final controller = Get.find<BudgetAllPageController>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(translation.userBudgetFilterPageTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),),
        actions: [
          IconButton(
            onPressed: () {
              // if(controller.premiumService.isPremium.value) {
              //   controller.selectMonthDialog();
              // }else {
              //   Get.toNamed(Routes.USERPREMIUM);
              // }
              controller.selectMonthDialog();
            },
            icon: const Icon(Icons.calendar_month_outlined),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppLayout.getHeight(8)),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => controller.budgetItems.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.budgetItems.length,
                          itemBuilder: (_, index) {
                            return Card(
                              child: ListTile(
                                  // leading: Icon(
                                  //   controller.categoryItems[index].icon,
                                  //   color: Colors.white,
                                  //   //size: 30,
                                  // ),
                                  title: Text(
                                      //"${_controller.budgetItems[index].creationDate!}"),
                                      "${translation.userBudgetPeriodText.tr}: ${DateFormat.yMMMM(Platform.localeName).format(DateUtils.dateOnly(controller.budgetItems[index].creationDate!))}"),
                                  subtitle: Text(
                                      "${translation.userBudgetFinalBalanceText.tr} ${controller.budgetItems[index].balance}"),
                                  onTap: () {
                                    // if (!controller
                                    //     .premiumService.isPremium.value) {
                                    //   AppAdManager().getVideoInterstitialAd(
                                    //       AppRoutes.BUDGETFULL,
                                    //       controller.budgetItems[index].id!);
                                    // } else {
                                    //   Get.toNamed(
                                    //     AppRoutes.BUDGETFULL,
                                    //     arguments:
                                    //         controller.budgetItems[index].id!,
                                    //   );
                                    // }

                                    //
                                    Get.toNamed(AppRoutes.BUDGETFULL,
                                        arguments:
                                        controller.budgetItems[index].id!);
                                  },
                                  trailing:
                                      const Icon(Icons.arrow_forward_ios_outlined)
                                  // PopupMenuButton(
                                  //   icon: const Icon(Icons.more_vert),
                                  //   itemBuilder: (context) {
                                  //     return [
                                  //       PopupMenuItem(
                                  //         value: CategoryPopupMenuItem.Edit,
                                  //         child: Text(translation.appEditButtonLabel.tr),
                                  //       ),
                                  //       PopupMenuItem(
                                  //         value: CategoryPopupMenuItem.Archived,
                                  //         child: Text(translation.appDeleteButtonLabel.tr),
                                  //       )
                                  //     ];
                                  //   },
                                  //   onSelected: (CategoryPopupMenuItem value) =>
                                  //       actionPopUpItemSelected(
                                  //           value, controller.categoryItems[index]),
                                  // ),
                                  ),
                            );
                          },
                        )
                      : Center(
                          child: Text(translation.userBudgetNotFoundText.tr),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
