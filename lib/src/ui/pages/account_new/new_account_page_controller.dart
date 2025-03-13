import 'dart:developer';
import 'dart:math' as math;

import 'package:akwe/src/data/services/account_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/account_type.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/banking.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/account_type_list.dart';
import 'package:akwe/src/utils/app_color.dart';
import 'package:akwe/src/utils/app_color_list.dart';
import 'package:akwe/src/utils/colors_mapping.dart';
import 'package:akwe/src/utils/instituitions_list.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:reactive_forms/reactive_forms.dart';

class NewAccountPageController extends GetxController {
  final AccountService _accountService = AccountService();
  final StorageService _storageService = StorageService();
  final _random = math.Random();

  var banks = <Bank>[].obs;
  var isFund = false.obs;
  var accountBalance = TextEditingController(text: "0");
  var accountName = TextEditingController();
  var accountDescription = TextEditingController();
  var accountType = AccountType(
    11,
    translation.userAccountType011.tr,
    const Icon(Icons.wallet_outlined),
  ).obs;
  var accountTypeValue = "".obs;
  var selectedIndex = 0.obs;
  var selectedColor = AppColor(key: 70000, color: const Color(0xFF013F3A)).obs;
  var selectedBank =
      Bank(7070, "Carteira", "assets/banks/wallet_PNG77083.png").obs;
  var app_color_list = getAppColorList();
  var app_bank_list = getBankInstitution();
  final accountTypes = getAccountType();

  final form = fb.group({
    'balance': FormControl<double>(
        value: 0.0, validators: [Validators.required, Validators.min(0.5)]),
    'name': FormControl<String>(validators: [
      Validators.required,
      Validators.maxLength(20),
      Validators.minLength(5),
      // ShortFieldValidator()
    ]),
    'description': FormControl<String>(value: ""),
    "color": FormControl<int>(validators: [Validators.required]),
    // 'icon': FormControl<int>(validators: [Validators.required]),
    'bank_code': FormControl<int>(validators: [Validators.required]),
    'account_type': FormControl<int>(validators: [Validators.required]),
    'is_fund':
        FormControl<bool>(value: false, validators: [Validators.required]),
  });

  @override
  void onInit() {
    print("Init...");
    form.control("account_type").value = accountType.value.key;
    form.control("bank_code").value = selectedBank.value.key;
    form.control("color").value = selectedColor.value.key;
    super.onInit();
  }

  @override
  void onClose() {
    // accountBalance.dispose();
    // accountName.dispose();
    // accountDescription.dispose();
    super.onClose();
  }

  toggle() {
    isFund.value = !isFund.value;
    update();
  }

  updateAccountType(int value) {
    accountType.value =
        accountTypes.singleWhere((element) => element.key == value);
    form.control("account_type").value = accountType.value.key;
    update();
  }

  updateAccountTypeValue(String value) {
    accountTypeValue.value = value;
    update();
  }

  getValidatedFormValue() async {
    DialogHelper.showLoading();
    try {
      var data = AppAccount(
        name: accountName.text.trim(),
        balance: double.tryParse(
                accountBalance.value.text.trim().removeAllWhitespace) ??
            0.0,
        description: accountDescription.text.trim() ?? "",
        accountType: accountType.value,
        bank: selectedBank.value,
        color: selectedColor.value,
        isFund: isFund.value,
      ).toJson();

      dio.Response response = await _accountService.create(data);

      if (response.statusCode == StatusCode.OK) {
        // await _storageService.addNewAccount(response.data);
        log("Saving new account to storage");
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appMessageUpdateCreatedText.tr,
          color: AppColorList.APPCOLOR022,
        );
        Get.toNamed(AppRoutes.HOME);
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  updateSelectedColor(int index) {
    selectedIndex.value = index;
    selectedColor(app_color_list[index]);
    form.control("color").value = selectedColor.value.key;
    update();
  }

  updateSelectedBank(Bank bank) {
    selectedBank.value = bank; //app_bank_list[index]);
    form.control("bank_code").value = selectedBank.value.key;
    update();
  }

  validForm() {
    print(this.form.value);
  }
}
