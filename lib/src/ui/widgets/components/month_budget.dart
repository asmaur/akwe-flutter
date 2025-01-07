import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';

class MonthBudget extends StatelessWidget {
  const MonthBudget({super.key});

  @override
  Widget build(BuildContext context) {
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
          width: AppLayout.getScreenWidth() * 0.95,
          height: AppLayout.getHeight(100),
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
                        translation.appMonthBudgetTitle.tr,
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
                    "R\$ 15.000,23",
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
