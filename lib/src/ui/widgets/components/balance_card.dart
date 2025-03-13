import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/budgets/budget.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class BalanceCard extends StatelessWidget {
  BalanceCard({super.key, required this.budget});
  final locale = Get.deviceLocale;
  final Budget budget;

  @override
  Widget build(BuildContext context) {

    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppColors.appDarkGreen,
        elevation: 5,
        child: Container(
          width: 95.w,
          height: AppLayout.getHeight(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.purpleAccent,
                //width: 10.w, //(AppLayout.getScreenWidth() * 0.7),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, left: 5, right: 5),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text(
                              translation.appHomeMainBudgetText.tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w300,
                                color: AppColors.appGray,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              // width: 250,
                              // color: Colors.yellow,
                              child: Text(
                                currency.format(budget.balance),
                                style: TextStyle(
                                  fontSize: 27.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.appWhite,
                                  fontFamily: GoogleFonts.raleway()
                                      .fontFamily,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: budget.initialBalance ==
                              0.0
                              ? ElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.NEWBUDGET,
                                  arguments: budget.id!);
                            },
                            child: Text(translation
                                .userBudgetCreateButtonText
                                .tr),
                          )
                              : ElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.BUDGET,
                                  arguments: budget.id!);
                            },
                            child: Text(translation
                                .userBudgetViewHistoryButtonText
                                .tr),
                          ),
                        )
                        // ElevatedButton(
                        //   onPressed: () {
                        //   },
                        //   child: Text(
                        //     translation.userBudgetDetailTitle.tr,
                        //   ),
                        // ),

                    ],
                  ),
                ),
              ),
              Container(
                // color: Colors.lightBlue,
                width: 20.w,//(AppLayout.getScreenWidth() * 0.5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.appWhite,
                            ),
                            child: Center(
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.appYellow,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 108,
                            width: 200,
                            child: Image.asset(
                              "assets/images/group-36.png",
                              fit: BoxFit.cover,
                              // height: 100,
                              // width: 180,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
