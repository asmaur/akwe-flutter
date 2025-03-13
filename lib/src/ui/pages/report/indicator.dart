import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/app_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    //required this.color,
    //required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
    this.data
  });

  //final Color color;
  //final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;
  final ChartData? data;

  @override
  Widget build(BuildContext context) {
    final locale = Get.deviceLocale;
    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );


    return Card(
      color: Theme.of(context).brightness == Brightness.light ? AppColors.appWhite : AppColors.appBlack,
      margin: EdgeInsets.only(left: AppLayout.getHeight(20), right: AppLayout.getHeight(20), bottom: AppLayout.getHeight(5),),
      //padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: AppLayout.getHeight(40),
            width: AppLayout.getHeight(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: data?.color,
            ),
          ),
          Container(
            width: AppLayout.getScreenWidth() * 0.7,
            margin: EdgeInsets.only(right: AppLayout.getHeight(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        data!.name!,
                        style: TextStyle(
                          fontSize: AppLayout.getHeight(12),
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ),
                    Text(
                      currency.format(data!.value),
                      style: TextStyle(
                        fontSize: AppLayout.getHeight(12),
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translation.appChartIndicatorLabel.tr,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: AppLayout.getHeight(10)),
                    ),
                    Text(
                      "${data!.percent}%",
                      style: TextStyle(
                        fontSize: AppLayout.getHeight(10),
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
