import 'dart:io';

import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

import 'budget_list_page_controller.dart';

class BudgetListPage extends StatelessWidget {
  BudgetListPage({super.key});
  final controller = Get.find<BudgetListPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation.appDrawerBudgetText.tr,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
        ),
        //actions: [
        // IconButton(
        //   onPressed: () {
        //     //Get.toNamed(Routes.BUDGETALL);
        //   },
        //   icon: Icon(
        //     Icons.filter_alt,
        //     size: AppLayout.getHeight(20),
        //   ),
        //   tooltip: "Filter",
        // )
        //],
      ),
      //floatingActionButton: FloatingActionButton.small(onPressed: (){}, child: Icon(Icons.arrow_forward_ios_outlined),),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppLayout.getHeight(8)),
          child: Obx(
            () => controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.appDarkGreen,
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
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
                                      "${translation.userBudgetPeriodText.tr} ${DateFormat.yMMMM(Platform.localeName).format(controller.budgetItems[index].creationDate!)}"),
                                  subtitle: Text(
                                      "${translation.userBudgetFinalBalanceText.tr} ${controller.budgetItems[index].balance}"),
                                  onTap: () {
                                    // if (!controller.premiumService.isPremium.value) {
                                    //   AppAdManager().getVideoInterstitialAd(
                                    //       AppRoutes.BUDGETFULL,
                                    //       controller.budgetItems[index].id!);
                                    // } else {
                                    //   Get.toNamed(AppRoutes.BUDGETFULL,
                                    //     arguments: controller.budgetItems[index]
                                    //         .id!,);
                                    // }
                                    Get.toNamed(
                                      AppRoutes.BUDGETFULL,
                                      arguments:
                                          controller.budgetItems[index].id!,
                                    );
                                  },
                                  trailing: const Icon(
                                      Icons.arrow_forward_ios_outlined)),
                            );
                          },
                          // separatorBuilder: (context, index) {
                          //   return const Divider(
                          //     color: Colors.black,
                          //   );
                          // },
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          // if (controller.premiumService.isPremium.value) {
                          //   Get.toNamed(AppRoutes.BUDGETALL);
                          //  }else {
                          //    Get.toNamed(AppRoutes.USERPREMIUM);
                          //  }
                          Get.toNamed(AppRoutes.BUDGETALL);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.appWhite
                                    : AppColors.appDarkGreen,
                          ),
                        ),
                        child: Text(
                          translation.appSeeMoreButtonLabel.tr,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
