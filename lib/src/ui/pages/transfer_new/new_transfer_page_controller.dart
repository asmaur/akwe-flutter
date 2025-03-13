import 'package:akwe/src/constants/storage_items.dart';
import 'package:akwe/src/data/services/transfer_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/transfers/transfer.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/colors_mapping.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;



class NewTransferPageController extends GetxController{
  final StorageService _storageService = StorageService();
  final TransferService _service = TransferService();
  var processed = true.obs;
  var accounts = <AppAccount>[].obs;
  var fromSelectedAccount = AppAccount().obs;
  var inSelectedAccount = AppAccount().obs;
  var name = TextEditingController();
  var amount = TextEditingController(text: "0");
  var description = TextEditingController();

  var startDate = DateTime.now().obs;
  TextEditingController dateInput = TextEditingController(text: DateFormat("dd/MM/yyyy").format(DateTime.now()));


  @override
  void onInit() {
    loadAccounts();
    super.onInit();
  }

  @override
  void onClose() {
    name.dispose();
    description.dispose();
    amount.dispose();
    dateInput.dispose();
    super.onClose();
  }

  toggle() {
    processed.value = !processed.value;
    update();
  }

  loadAccounts() async {
    var values = await _storageService.list(AppLocalStore.ACCOUNTSTORE);
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        accounts.add(AppAccount.fromJson(element));
      }
      fromSelectedAccount.value = accounts.first;
      inSelectedAccount.value = accounts.first;
      //Future.delayed(Duration(seconds: 2));
    }
  }

  updateFromAccount(String id) {
    fromSelectedAccount.value = accounts.singleWhere((element) => element.id==id);
    update();
  }

  updateInAccount(String id) {
    inSelectedAccount.value = accounts.singleWhere((element) => element.id==id);
    update();
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: startDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != startDate.value) {
      startDate.value = pickedDate;
      dateInput.text = DateFormat("dd/MM/yyyy").format(pickedDate);
    } else {
      print("Date is not selected");
    }
  }

  createNewTransfer() async{
    DialogHelper.showLoading();
    try {
      var value = double.tryParse(amount.text.trim());

      if(fromSelectedAccount.value.balance! < value! ){
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(title: translation.appLocalAuthDialogTitle.tr, message: translation.appTransferInsufficientBalanceMessage.tr);
        return;
      }
      if(fromSelectedAccount.value.id == inSelectedAccount.value.id){
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(title: translation.appLocalAuthDialogTitle.tr, message: translation.appTransferSameAccountMessage.tr);

        return;
      }
      var data = Transfer(
          name: name.text.trim(),
          processed: processed.value,
          description: description.text.trim() ?? "",
          amount: double.tryParse(amount.text.trim()),
          executionDate: startDate.value,
          fromAccount: fromSelectedAccount.value,
          inAccount: inSelectedAccount.value
      ).toJson();

      dio.Response  response = await _service.create(data);

      if(response.statusCode == StatusCode.CREATED){
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appMessageUpdateCreatedText.tr,
          color: AppColorList.APPCOLOR022,
        );
        Get.offAllNamed(AppRoutes.HOME);
      }
      
    } on dio.DioException catch(e){
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }

  }

}