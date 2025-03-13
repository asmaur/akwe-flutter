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
import 'package:akwe/src/utils/instituitions_list.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:reactive_forms/reactive_forms.dart';


class EditAccountPageController extends GetxController{
  final StorageService _storageService = StorageService();
  final AccountService _service = AccountService();

  var name = TextEditingController(text: "");
  var description = TextEditingController(text: "");
  var accountBalance = TextEditingController(text: "0");
  var isFund = false.obs;
  var id = "".obs;
  var account = AppAccount().obs;
  var accountType = AccountType(11,
    translation.userAccountType011.tr,
    const Icon(Icons.wallet_outlined),).obs;
  var accountTypeIndex = 0.obs;
  var accountTypeValue = "".obs;
  var selectedIndex = 0.obs;
  var selectedColor = AppColor(key: 70000, color: const Color(0xFF013F3A)).obs;
  var selectedBank = Bank(7070, "Carteira", "assets/banks/wallet_PNG77083.png").obs;
  var app_color_list = getAppColorList();
  var app_bank_list = getBankInstitution();
  //final appColors = getAppColorList();
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
    'bank_code': FormControl<int>(validators: [Validators.required]),
    'account_type': FormControl<int>(validators: [Validators.required]),
    'is_fund':
    FormControl<bool>(value: false, validators: [Validators.required]),
  });


  @override
  void onInit() {
    id.value = Get.arguments;
    loadAccount();
    super.onInit();
  }

  @override
  void onClose(){
    name.dispose();
    description.dispose();
    accountBalance.dispose();
    super.onClose();
  }


  toggle() {
    isFund.value = !isFund.value;
    update();
  }

  loadAccount() async{
    var currentAccount = await _storageService.retrieve("accounts", id.value);//getAccount(id.value);
    account.value = currentAccount;//AppAccount.fromJson(currentAccount);
    // name.text = account.value.name!;
    // description.text = account.value.description!;
    // isFund.value = account.value.isFund!;
    // accountBalance.text = "${account.value.balance}";
    selectedBank(account.value.bank);
    selectedColor(account.value.color);
    setCurrentColorIndex(account.value.color!);

    form.control("balance").value = account.value.balance;
    form.control("name").value = account.value.name;
    form.control("description").value = account.value.description;
    form.control("color").value = account.value.color?.key;
    form.control("bank_code").value = account.value.bank?.key;
    form.control("account_type").value = account.value.accountType?.key;
    form.control("is_fund").value = account.value.isFund;

  }

  updateAccount() async{
    DialogHelper.showLoading();
    try {

      var data = AppAccount(
        name: name.text.trim(),
        balance: double.tryParse(
            accountBalance.value.text.trim().removeAllWhitespace) ??
            0.0,
        description: description.text.trim() ?? "",
        accountType: accountType.value,
        bank: selectedBank.value,
        color: selectedColor.value,
        isFund: isFund.value,
      ).toJson();

      dio.Response response = await _service.update(data, account.value.id!,);

      if(response.statusCode == StatusCode.OK){
        DialogHelper.hideLoading();
        // await _storageService.updateAccount(response.data, account.value.id!);
        Get.offAllNamed(AppRoutes.HOME);

      }

    }on dio.DioException catch(e){
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }

  }

  updateSelectedColor(int index){
    selectedIndex.value = index;
    selectedColor(app_color_list[index]);
    update();
  }

  updateSelectedBank(Bank bank){
    selectedBank.value = bank;//app_bank_list[index]);
    update();
  }

  updateAccountType(int value) {
    accountType.value = accountTypes.singleWhere((element) => element.key==value);
    update();
  }

  updateAccountTypeValue(String value) {
    accountTypeValue.value = value;
    update();
  }

  setCurrentColorIndex(AppColor color){
    selectedIndex.value = app_color_list.indexWhere((element) => color.key == element.key);
  }


}