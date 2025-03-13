import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/budgets/budget.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';
import 'package:in_date_utils/in_date_utils.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class MonthBudget extends StatelessWidget {
  MonthBudget({super.key, required this.budget});
  final Budget budget;
  final locale = Get.deviceLocale;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    return Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(
              top: 16,
              bottom: 8,
            ),
            child: Text(
              translation.appRecomendLabelText.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          width: 95.w, //AppLayout.getScreenWidth() * 0.95,
          height: AppLayout.getHeight(10),
          child: Card(
            color: AppColors.appPurple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(12.0),
                      child: Text(
                        translation.appMonthBudgetTitle.trParams({
                          "monthName": DateFormat.MMMM(Get.locale?.languageCode)
                              .format(budget.creationDate ?? DateTime.now()),
                        }),
                        style: TextStyle(
                          color: AppColors.appWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        translation.appMonthBudgetSettedDate.tr,
                        style: TextStyle(
                          color: AppColors.appWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    currency.format(budget.initialBalance),
                    style: TextStyle(
                      color: AppColors.appWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
