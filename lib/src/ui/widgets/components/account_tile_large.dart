import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/popup_menu.dart';
import 'package:akwe/src/data/services/account_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class AccountTileLarge extends StatelessWidget {
  AccountTileLarge({super.key, required this.account});
  final AppAccount account;

  final AccountService _service = AccountService();
  // final AccountStorageService _storageService = AccountStorageService();

  @override
  Widget build(BuildContext context) {
    AccountPopupMenuItem? selectedItem;

    final locale = Get.deviceLocale;

    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    return Card(
      color: Theme.of(context).brightness.name == "dark"
          ? AppColors.appDarkGreen
          : AppColors.appMidGray, //account.color?.color,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              account.name!,
            ), //style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.appWhite, fontSize: 18),),
            visualDensity: const VisualDensity(vertical: -4),
            trailing: PopupMenuButton(
              initialValue: selectedItem,
              icon: const Icon(Icons.more_horiz_outlined),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: AccountPopupMenuItem.view,
                    child: const Text("Detail"),
                  ),
                  PopupMenuItem(
                    value: AccountPopupMenuItem.edit,
                    child: Text(translation.appEditButtonLabel.tr),
                  ),
                  PopupMenuItem(
                    value: AccountPopupMenuItem.archived,
                    child: Text(translation.appDeleteButtonLabel.tr),
                  )
                ];
              },
              onSelected: (AccountPopupMenuItem item) {
                actionPopUpItemSelected(item);
              },
            ),
          ),
          //SizedBox(child: Text("Conta corrente"),),

          const Divider(),

          ListTile(
            leading: SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(
                account.bank!.logo!,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(account.bank!.name!),
            subtitle: Text(
              account.accountType!.name,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 12),
            ),
            // trailing: IconButton(
            //     onPressed: () {}, icon: Icon(Icons.more_horiz_outlined),
            // ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation.appPerformanceBalanceLabel.tr),
                Text(
                  currency.format(account.balance),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  archiveAccount(String id) async {
    DialogHelper.showLoading();
    try {
      dio.Response response = await _service.delete(id);

      if (response.statusCode == StatusCode.NO_CONTENT) {
        // await _storageService.deleteAccount(id);
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

  void actionPopUpItemSelected(AccountPopupMenuItem item) {
    switch (item) {
      case AccountPopupMenuItem.view:
        Get.toNamed(AppRoutes.USERACCOUNTDETAIL, arguments: account.id);
        return;
      case AccountPopupMenuItem.edit:
        Get.toNamed(AppRoutes.EDITACCOUNT, arguments: account.id);
        return;
      case AccountPopupMenuItem.archived:
        DialogHelper.showErrorDialog(
          title: translation.appMessageConfirm.tr,
          description: translation.appMessageConfirmText
              .trParams({"name": "${account.name}"}),
          onConfirm: () => account.isDefault!
              ? DialogHelper.showSnackBar(
                  title: translation.appMessageError.tr,
                  message: translation.appItemDefault.tr,
                )
              : archiveAccount(account.id!),
        );
        return;
    }
  }
}
