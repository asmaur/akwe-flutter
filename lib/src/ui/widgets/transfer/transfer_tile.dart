import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/constants/popup_menu.dart';
import 'package:akwe/src/data/services/transfer_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/transfers/transfer.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/date_utils.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;


class TransferTile extends StatelessWidget {
  TransferTile({super.key, this.transfer});
  final Transfer? transfer;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  //String locale = Platform.localeName;
  final locale = Get.deviceLocale;
  TransferPopupMenuItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    // final DateFormat formatter = DateFormat('dd/MM/yyyy');
    // //String locale = Platform.localeName;
    // final locale = Get.deviceLocale;
    // TransferPopupMenuItem? selectedItem;

    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );
    // final premiumService = Get.find<AppPremiumService>();



    return GestureDetector(
      onTap: () {

        // if (!premiumService.isPremium.value) {
        //   AppAdManager()
        //       .getVideoInterstitialAd(Routes.TRANSFERDETAIL, transfer?.id);
        // }else {
        //   Get.toNamed(Routes.TRANSFERDETAIL, arguments: transfer?.id);
        // }
      },
      child: Card(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : AppColors.appDarkGreen,
        child: Container(
          height: 60,
          margin: EdgeInsets.all(AppLayout.getHeight(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: AppLayout.getWidth(30),
                    height: AppLayout.getHeight(30),
                    margin: const EdgeInsets.only(left: 5, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: transfer!.processed! ? Colors.green.shade700 :  Colors.redAccent.shade700,
                    ),
                    child: transfer!.processed! ? const Icon(Icons.check) : const Icon(Icons.question_mark),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transfer!.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          //color: AppColors.appMidYellow,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.remove, color: Colors.redAccent.shade700, size: 14,),
                          const SizedBox(width: 2,),
                          Text(
                            transfer!.fromAccount!.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              //color: AppColors.appMidYellow,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.add, color: Colors.greenAccent.shade700, size: 14,),
                          const SizedBox(width: 2,),
                          Text(
                            transfer!.inAccount!.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              //color: AppColors.appMidYellow,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        AppDateUtils().checkDate(transfer!.executionDate!),
                        //date != null ? formatter.format(date!) : "";
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        currency.format(transfer!.amount!),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.yellow.shade700, //AppColors.appMidYellow,
                        ),
                      ),
                    ],
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.more_vert_outlined),
                  // )
                  PopupMenuButton(
                    initialValue: selectedItem,
                    icon: const Icon(Icons.more_vert_outlined),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: TransferPopupMenuItem.view,
                          child: Text(translation.appPopupMenuDetailText.tr),
                        ),
                        PopupMenuItem(
                          value: TransferPopupMenuItem.edit,
                          child: Text(translation.appPopupMenuEditText.tr),
                        ),
                        PopupMenuItem(
                          value: TransferPopupMenuItem.delete,
                          child: Text(translation.appPopupMenuDeleteText.tr),
                        )
                      ];
                    },
                    onSelected: (TransferPopupMenuItem item) {
                      actionPopUpItemSelected(item, transfer!);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  deleteTransfer(int id) async {
    final TransferService service = TransferService();
    DialogHelper.showLoading();
    try {
      dio.Response response = await service.delete(id);

      if (response.statusCode == StatusCode.NO_CONTENT) {
        //await _storageService.deleteAccount(id);
        DialogHelper.hideLoading();
        Get.offAllNamed(AppRoutes.HOME);
      }
    } on dio.DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  void actionPopUpItemSelected(TransferPopupMenuItem item, Transfer transfer) {
    // final premiumService = Get.find<AppPremiumService>();

    switch (item) {
      case TransferPopupMenuItem.view:
        // if(!premiumService.isPremium.value) {
        //   AppAdManager().getNoRouteVideoInterstitialAd();
        //   Get.toNamed(AppRoutes.TRANSFERDETAIL, arguments: transfer.id);
        // }else {
        //   Get.toNamed(AppRoutes.TRANSFERDETAIL, arguments: transfer);
        // }
        return;
      case TransferPopupMenuItem.edit:
        // if(!premiumService.isPremium.value) {
        //   AppAdManager().getNoRouteVideoInterstitialAd();
        //   Get.toNamed(AppRoutes.EDITTRANSFER, arguments: transfer);
        // }else {
        //   Get.toNamed(AppRoutes.EDITUSERGOAL, arguments: transfer);
        // }
        return;

      case TransferPopupMenuItem.delete:
        DialogHelper.showErrorDialog(
          title: translation.appMessageConfirm.tr,
          description: translation.appMessageConfirmText
              .trParams({"name": "${transfer.name}"}),
          onConfirm: () => deleteTransfer(transfer.id!),
        );
        return;
    }
  }

}
