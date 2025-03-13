import 'dart:io';

import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/constants/popup_menu.dart';
import 'package:akwe/src/ui/pages/planning_filter/planning_filter_page_controller.dart';
import 'package:akwe/src/ui/pages/transaction_all/transaction_all_page_controller.dart';
import 'package:akwe/src/ui/widgets/components/routine_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class PlanningFilterPage extends StatelessWidget {
  const PlanningFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanningFilterPageController>();
    AppPopupExportMenu? selectedItem;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(translation.appPlanningFilterTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),),
          actions: [
            Container(
              margin: EdgeInsets.only(right: AppLayout.getHeight(10)),
              child: DropdownButton(
                value: controller.selectedItem.value,
                items: controller.filterMenuItems
                    .map((item) => DropdownMenuItem<AppBasicFilterItem>(
                          value: item,
                          child: Text(item.value!),
                        ))
                    .toList(),
                onChanged: (item) {
                  controller.updateSelectedFilter(item!);
                },
              ),
            ),
            IconButton(
              onPressed: () {

                // if (!controller.premiumService.isPremium.value) {
                //   AppAdManager().getNoRouteVideoInterstitialAd();
                // }
                // showDateFilterDialog();

                // if(_controller.premiumService.isPremium.value) {
                //   showDateFilterDialog();
                // }else{
                //   Get.toNamed(Routes.USERPREMIUM);
                // }
              },
              icon: const Icon(Icons.calendar_month_outlined),
            ),

            PopupMenuButton(
              initialValue: selectedItem,
              icon: const Icon(Icons.more_vert_outlined),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: AppPopupExportMenu.excel,
                    child: const Text("Excel"),//translation.appPopupMenuDetailText.tr),
                  ),

                  PopupMenuItem(
                      value: AppPopupExportMenu.csv,
                      child:
                      const Text("CSV")//translation.appPopupMenuArchiveText.tr),
                  ),
                  // const PopupMenuItem(
                  //   value: AppPopupExportMenu.Pdf,
                  //   child: Text("PDF"),//translation.appPopupMenuEditText.tr),
                  // ),
                ];
              },
              onSelected: (AppPopupExportMenu item) {
                controller.actionPopUpItemSelected(item);
              },
            ),
          ],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.appWhite
                        : AppColors.appDarkGreen,
                  ),
                )
              : controller.filteredRoutines.isNotEmpty
                  ? ListView.separated(
                      itemCount: controller.filteredRoutines.length,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            left: AppLayout.getHeight(25),
                            right: AppLayout.getHeight(25),
                          ),
                          child: RoutineTile(
                            routine: controller.filteredRoutines[index],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        // if (index % 2 == 0) {
                        //   return AppAdManager().getBannerAd();
                        // } else if (controller.filteredRoutines.length - 1 ==
                        //     index) {
                        //   return AppAdManager().getBannerAd();
                        // }
                        return const SizedBox();
                      },
                    )
                  : Container(
                      child: Center(
                        child:
                            Text(translation.appRoutineNoRoutineFoundText.tr),
                      ),
                    ),
        ),
      ),
    );
  }

  showDateFilterDialog() {
    final controller = Get.find<PlanningFilterPageController>();

    Get.dialog(
        barrierDismissible: false,
        Dialog(
          child: Container(
            padding: EdgeInsets.all(AppLayout.getHeight(10)),
            decoration: BoxDecoration(
                //color: Colors.white,
                borderRadius: BorderRadius.circular(AppLayout.getHeight(20))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(translation.appFilterSelectDatesLabel.tr),
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: controller.selectDateRange,
                          child: Text(
                            DateFormat.yMd(Platform.localeName)
                                .format(controller.dateRange.value.start),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: controller.selectDateRange,
                          child: Text(
                            DateFormat.yMd(Platform.localeName).format(
                              controller.dateRange.value.end,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Container(
                  width: AppLayout.getScreenWidth() * 0.7,
                  padding: EdgeInsets.only(
                    top: AppLayout.getHeight(20),
                    bottom: AppLayout.getHeight(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.appDarkGreen)),
                        child: Text(
                          translation.appCancelButtonLabel.tr,
                          // style: Theme
                          //     .of(Get.context!)
                          //     .textTheme
                          //     .labelLarge
                          //     ?.copyWith(color: AppColors.appWhite),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Get.back();
                          controller.filterByDateRange();
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.appDarkGreen,
                            side: const BorderSide(color: Colors.transparent)),
                        child: Text(
                          translation.appFilterButtonLabel.tr,
                          style: Theme.of(Get.context!)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: AppColors.appWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        // style: ButtonStyle(
                        //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        //         (Set<MaterialState> states) {
                        //       if (states.contains(MaterialState.pressed)) {
                        //         return AppColors.appRed;
                        //       }
                        //       return AppColors.appRed;
                        //     },
                        //   ),
                        //   shape: MaterialStateProperty.all(
                        //     RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30),
                        //       side: const BorderSide(color: AppColors.appRed, width: 0)
                        //     )
                        //   )
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
