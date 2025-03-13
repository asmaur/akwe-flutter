import 'dart:developer';
import 'package:akwe/src/constants/popup_menu.dart';
import 'package:akwe/src/data/services/account_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class AccountDetailPageController extends GetxController {
  final AccountService _service = AccountService();
  final StorageService _storageService = StorageService();
  var id = "".obs;
  var account = AppAccount().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    id.value = Get.arguments;

    getAccountDetail();
    super.onInit();
  }

  getAccountDetail() async {
    try {
      dio.Response response = await _service.retrieve(id.value);

      if (response.statusCode == StatusCode.OK) {
        account.value = AppAccount.fromJson(response.data);
        isLoading.value = false;
      }
    } on dio.DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      isLoading.value = false;
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
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

  void actionPopUpItemSelected(AccountPopupMenuItem value) {
    if (value == AccountPopupMenuItem.edit) {
      Get.toNamed(AppRoutes.EDITACCOUNT, arguments: account.value.id);
    } else if (value == AccountPopupMenuItem.archived) {
      DialogHelper.showErrorDialog(
        title: translation.appMessageConfirm.tr,
        description: translation.appMessageConfirmText
            .trParams({"name": "${account.value.name}"}),
        onConfirm: () => account.value.isDefault!
            ? DialogHelper.showSnackBar(
                title: translation.appMessageError.tr,
                message: translation.appItemDefault.tr,)
            : archiveAccount(account.value.id!),
      );
    } else {
      log("LOG: Error while deleting account.");
    }
  }
}
