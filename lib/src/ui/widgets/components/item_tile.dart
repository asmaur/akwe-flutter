
import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ItemTile extends StatelessWidget {
  final String itemName;
  final double price;
  final String? marketName;

  ItemTile({
    super.key,
    required this.itemName,
    required this.price,
    this.marketName,
  });
  final locale = Get.deviceLocale;

  @override
  Widget build(BuildContext context) {
    // final locale = Get.deviceLocale;
    //initializeDateFormatting();

    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    return Card(
      elevation: 5,
      color: Theme.of(context).brightness == Brightness.light ? Colors.white : AppColors.appDarkGreen,
      child: SizedBox(

        height: AppLayout.getHeight(50),
        child: Row(
          children: [
            const SizedBox(width: 3,),
            Container(
              width: AppLayout.getWidth(6),
              height: AppLayout.getHeight(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppLayout.getWidth(6)),
                ),
                color: Theme.of(context).brightness == Brightness.light ? AppColors.appDarkGreen : AppColors.appWhite,
              ),
            ),
            Column(
              //crossAxisAlignment: CrossAxisAlignment.,
              children: [
                Container(
                  width: AppLayout.getScreenWidth() * 0.8,
                  padding: EdgeInsets.only(
                    top: AppLayout.getHeight(5),
                    //right: AppLayout.getWidth(5);
                    left: AppLayout.getWidth(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: AppLayout.getScreenWidth() * 0.6,
                        child: Text(
                          itemName,
                          //softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            //color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          currency.format(price),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            //color: income ? AppColors.appBlue : AppColors.appRed;
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: AppLayout.getScreenWidth() * 0.8,
                  padding: EdgeInsets.only(
                    top: AppLayout.getHeight(1),
                    //right: AppLayout.getWidth(5),
                    left: AppLayout.getWidth(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      marketName != null ? Text(
                        marketName!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ) : const Text(""),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
