import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

import 'goal_detail_page_controller.dart';

class GoalDetailPage extends StatelessWidget {
  const GoalDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GoalDetailPageController>();

    final locale = Get.deviceLocale;

    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(translation.appGoalDetailPageTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      color: controller.currentGoal.value.color?.color,
                      borderRadius: BorderRadius.circular(50)),
                  width: 35,
                  height: 35,
                  child: Icon(
                    controller.currentGoal.value.icon?.icon,
                    color: AppColors.appWhite,
                    size: 24,
                  ),
                ),
                title: Text(controller.currentGoal.value.name!, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),),
                subtitle: Text(DateFormat.yMMMd(locale?.languageCode).format(controller.currentGoal.value.deadlineDate!)),
              ),
              Gap(AppLayout.getHeight(10)),
              Container(
                child: CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: double.parse(
                      (controller.currentGoal.value.balance! *
                              1 /
                              controller.currentGoal.value.targetAmount!)
                          .toStringAsFixed(1),),
                  center: Text(
                    "${(controller.currentGoal.value.balance! * 100 / controller.currentGoal.value.targetAmount!).toStringAsFixed(1)}%",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  footer: Text(
                    "${currency.format(controller.currentGoal.value.balance)} ${translation.appGoalOfLabel.tr} ${currency.format(controller.currentGoal.value.targetAmount)}",
                    style:
                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: controller.currentGoal.value.color?.color,
                ),
              ),
              Gap(AppLayout.getHeight(20)),
              const Divider(),
              Container(
                width: AppLayout.getScreenWidth() * 0.9,
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
                          side: const BorderSide(color: AppColors.appRed)),
                      child: Text(
                        translation.appMarkDoneButtonLabel.tr,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.appRed,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.ADDDEPOSITTOGOAL, arguments: controller.currentGoal.value);
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.appRed,
                          side: const BorderSide(color: Colors.transparent)),
                      child: Text(
                        translation.appMakeDepositButtonLabel.tr,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
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
              const Divider(),

              // Center(
              //   child: Text("History"),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
