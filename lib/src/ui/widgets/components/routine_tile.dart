import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/routines/routine.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/date_utils.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:akwe/src/utils/payment_type_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RoutineTile extends StatelessWidget {
  RoutineTile({super.key, required this.routine,});
  final Routine routine;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  //String locale = Platform.localeName;
  final locale = Get.deviceLocale;

  @override
  Widget build(BuildContext context) {
    final routineTypes = getPaymentTypeList();



    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );
    // final premiumService = Get.find<AppPremiumService>();

    return GestureDetector(
      onTap: (){
        // if (!premiumService.isPremium.value) {
        //   AppAdManager()
        //       .getVideoInterstitialAd(Routes.ROUTINEDETAIL, routine?.id);
        // }else {
        //   Get.toNamed(Routes.ROUTINEDETAIL, arguments: routine?.id);
        // }
        Get.toNamed(AppRoutes.ROUTINEDETAIL, arguments: routine.id);
      },
      // onDoubleTap: onDoubleTap,
      // onLongPress: onLongPress,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.only(top: 8),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : AppColors.appDarkGreen,
        child: Container(
          width: AppLayout.getScreenWidth() * 0.85,
          height: AppLayout.getHeight(60),
          //padding: EdgeInsets.only(left: 1);
          decoration: const BoxDecoration(
            //color: Colors.redAccent;
            // border: Border.all(
            //     //color: income ? AppColors.appRed : AppColors.appBlue;
            //     );
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 3,
              ),
              Container(
                width: AppLayout.getWidth(6),
                height: AppLayout.getHeight(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppLayout.getWidth(6)),
                  ),
                  color: routine!.done!
                      ? Colors.transparent
                      : (routine!.income! ? AppColors.appBlue : AppColors.appRed),
                ),
              ),
              Column(
                children: [
                  Container(
                    //color: Colors.blueAccent,
                    width: AppLayout.getScreenWidth() * 0.8,
                    padding: EdgeInsets.only(
                      top: AppLayout.getHeight(5),
                      right: AppLayout.getWidth(5),
                      left: AppLayout.getWidth(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          routine.name!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color:
                            Theme.of(context).brightness == Brightness.light
                                ? (routine.income!
                                ? AppColors.appBlue
                                : AppColors.appRed)
                                : AppColors.appWhite,
                          ),
                        ),
                        Text(
                          currency.format(routine.amount),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color:
                            Theme.of(context).brightness == Brightness.light
                                ? (routine.income!
                                ? AppColors.appBlue
                                : AppColors.appRed)
                                : AppColors.appWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //color: Colors.red,
                    width: AppLayout.getScreenWidth() * 0.8,
                    padding: EdgeInsets.only(
                      top: AppLayout.getHeight(1),
                      right: AppLayout.getWidth(5),
                      left: AppLayout.getWidth(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getCurrentPaymentType(routineTypes, routine.paymentType!),
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          AppDateUtils().checkDate(routine.expirationDate!),
                          //date != null ? formatter.format(date!) : "";
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  getCurrentPaymentType(List<PaymentType> paymentTypes, int key) {
    for (PaymentType item in paymentTypes) {
      if (item.key == key) {
        return item.value;
      }
    }
  }

}

