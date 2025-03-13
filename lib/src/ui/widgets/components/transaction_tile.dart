import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:akwe/src/utils/payment_type_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class TransactionTile extends StatelessWidget {
  TransactionTile({
    super.key,
    required this.transaction,
  });
  final Transaction transaction;
  final locale = Get.deviceLocale;

  @override
  Widget build(BuildContext context) {
    // final premiumService = Get.find<AppPremiumService>();

    // initializeDateFormatting();

    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    final paymentTypes = getPaymentTypeList();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
      child: Card(
        elevation: 5,
        color: AppColors.appLighterDark,
        child: ListTile(
          // selected: true,
          // selectedTileColor: Colors.blue,
          leading: Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: transaction.income
                  ? AppColors.appDarkGreen
                  : AppColors.appRose,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: transaction.income
                  ? Icon(
                      Icons.arrow_upward_outlined,
                      size: 22.sp,
                      color: AppColors.appWhite,
                    )
                  : Icon(
                      Icons.arrow_downward_outlined,
                      size: 22.sp,
                      color: AppColors.appWhite,
                    ),
            ),
          ),
          title: Container(
            margin: EdgeInsets.only(bottom: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    transaction.auto! ? transaction.code! : transaction.name!,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                      overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ),
                Container(
                  child: Text(
                    (transaction.auto! && !transaction.processed!)
                        ? "--"
                        : currency.format(transaction.totalPayed),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? (transaction.income
                                      ? AppColors.appBlue
                                      : AppColors.appRed)
                                  : AppColors.appWhite,
                        ),
                  ),
                ),
              ],
            ),
          ),
          subtitle: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    getCurrentPaymentType(transaction.paymentMethod!).value,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Container(
                  child: Text(
                    DateFormat.MMMMEEEEd(locale?.languageCode)
                        .format(transaction.creationDate!),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            // if (!premiumService.isPremium.value) {
            //   AppAdManager()
            //       .getVideoInterstitialAd(Routes.TRANSACTIONDETAIL, transaction?.id);
            // }else {
            //   Get.toNamed(Routes.TRANSACTIONDETAIL, arguments: transaction?.id);
            // }
            Get.toNamed(AppRoutes.TRANSACTIONDETAIL, arguments: transaction.id);
          },
          onLongPress: () {
            print("object");
          },
        ),
      ),
    );

    //   GestureDetector(
    //   onTap: () {
    //     // if (!premiumService.isPremium.value) {
    //     //   AppAdManager()
    //     //       .getVideoInterstitialAd(Routes.TRANSACTIONDETAIL, transaction?.id);
    //     // }else {
    //     //   Get.toNamed(Routes.TRANSACTIONDETAIL, arguments: transaction?.id);
    //     // }
    //     Get.toNamed(AppRoutes.TRANSACTIONDETAIL, arguments: transaction.id);
    //   },
    //   onLongPress: () {
    //     print("object");
    //   },
    //   child: Card(
    //     elevation: 3,
    //     color: Theme.of(context).brightness == Brightness.light
    //         ? Colors.white
    //         : AppColors.appDarkGreen,
    //     child: SizedBox(
    //       height: 10.h, // AppLayout.getHeight(60),
    //       child: Row(
    //         //mainAxisAlignment: MainAxisAlignment.spaceBetween;
    //         children: [
    //           Container(
    //             width: 0.5.h,
    //             // height: AppLayout.getHeight(50),
    //             color: transaction.income ? Colors.blue : Colors.redAccent,
    //           ),
    //           Column(
    //             children: [
    //               Container(
    //                 width: 90.w, //AppLayout.getScreenWidth() * 0.8,
    //                 padding: EdgeInsets.only(
    //                   top: AppLayout.getHeight(1),
    //                   right: AppLayout.getWidth(1),
    //                   left: AppLayout.getWidth(1),
    //                 ),
    //                 color: Colors.red,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   //mainAxisSize: MainAxisSize.max;
    //                   //crossAxisAlignment: CrossAxisAlignment.end;
    //                   children: [
    //                     Text(
    //                       transaction.auto! ? transaction.code! : transaction.name!,
    //                       style: const TextStyle(
    //                         fontWeight: FontWeight.w500,
    //                         fontSize: 14,
    //                         //color: Colors.black;
    //                       ),
    //                     ),
    //                     Text(
    //                       (transaction.auto! && !transaction.processed!) ? "--" : currency.format(transaction.totalPayed),
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.w600,
    //                         fontSize: 12,
    //                         color:
    //                         Theme.of(context).brightness == Brightness.light
    //                             ? (transaction.income
    //                             ? AppColors.appBlue
    //                             : AppColors.appRed)
    //                             : AppColors.appWhite,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Gap(20),
    //               Container(
    //                 color: Colors.red,
    //                 width: 90.w, //AppLayout.getScreenWidth() * 0.8,
    //                 padding: EdgeInsets.only(
    //                   // top: AppLayout.getHeight(1),
    //                   // right: AppLayout.getWidth(5),
    //                   // left: AppLayout.getWidth(8),
    //                 ),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       getCurrentPaymentType(transaction.paymentMethod!)
    //                           .value,
    //                       style: const TextStyle(
    //                         fontSize: 10,
    //                       ),
    //                     ),
    //                     Text(
    //                       DateFormat.MMMMEEEEd(locale?.languageCode)
    //                           .format(transaction.creationDate!),
    //                       //date.toLocal().toString(),
    //                       style: const TextStyle(
    //                         fontSize: 10,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  getCurrentPaymentType(PaymentType pay) {
    return paymentTypes.singleWhere((element) => pay.key == element.key);
    // for (PaymentType item in paymentTypes) {
    //   if (item.key == key) {
    //     return item.value;
    //   }
    // }
  }
}
