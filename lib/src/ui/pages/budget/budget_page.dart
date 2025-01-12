import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:timelines_plus/timelines_plus.dart';

import 'budget_page_controller.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BudgetPageController controller = Get.find<BudgetPageController>();

    final locale = Get.deviceLocale;

    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation.userBudgetDetailTitle.tr,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.appDarkGreen
                    : Colors.white,
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(AppLayout.getHeight(10)),
                    Card(
                      child: Column(
                        children: [
                          Gap(AppLayout.getHeight(5)),
                          Center(
                            child: Text(translation.userBudgetDetailHistory.tr),
                          ),
                        ],
                      ),
                    ),
                    Gap(AppLayout.getHeight(10)),
                    controller.budget.value.histories != null
                        ? FixedTimeline.tileBuilder(
                            builder: TimelineTileBuilder.connectedFromStyle(
                              contentsAlign: ContentsAlign.alternating,
                              contentsBuilder: (context, index) => Padding(
                                padding:
                                    EdgeInsets.all(AppLayout.getHeight(24)),
                                child: Container(
                                  color: controller.budget.value
                                              .histories![index].percent! <
                                          50
                                      ? AppColors.appDarkGreen
                                      : (controller.budget.value
                                                  .histories![index].percent! <
                                              70
                                          ? AppColors.appYellow
                                          : AppColors.appRed),
                                  padding:
                                      EdgeInsets.all(AppLayout.getHeight(5)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${currency.format(
                                          controller.budget.value
                                              .histories![index].expense!,
                                        )}(${controller.budget.value.histories![index].percent!}%)",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                      ),
                                      Text(
                                        DateFormat.yMMMd().format(controller
                                            .budget
                                            .value
                                            .histories![index]
                                            .creationDate!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              connectorStyleBuilder: (context, index) {
                                return ConnectorStyle.dashedLine;
                              },
                              indicatorStyleBuilder: (context, index) =>
                                  IndicatorStyle.dot,
                              itemCount:
                                  controller.budget.value.histories!.length,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
      ),
    );
  }
}
