import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/budgets/budget.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IncomeTile extends StatelessWidget {
  IncomeTile({super.key, required this.budget});
  final locale = Get.deviceLocale;
  final Budget budget;

  @override
  Widget build(BuildContext context) {
    // final locale = Get.deviceLocale;

    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: AppLayout.getScreenWidth() * .45,
        height: AppLayout.getHeight(200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.appLightBlue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 48,
              width: 48,
              margin: EdgeInsets.only(
                top: 16,
                right: 38,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.appDarkGreen,
              ),
              child: Center(
                child: Icon(
                  Icons.trending_up_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 18),
                    child: Text(
                      currency.format(budget.incomes),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        fontFamily:
                        GoogleFonts.roboto().fontFamily,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      translation.appPerformanceIncomeLabel.tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        fontFamily:
                        GoogleFonts.roboto().fontFamily,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
