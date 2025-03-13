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

class EditTransferPageController extends GetxController {
  final StorageService _storageService = StorageService();
  final TransferService _service = TransferService();

  var transfer = Transfer().obs;

  var processed = true.obs;
  var accounts = <AppAccount>[].obs;
  var fromSelectedAccount = AppAccount().obs;
  var inSelectedAccount = AppAccount().obs;
  var name = TextEditingController();
  var amount = TextEditingController(text: "0");
  var description = TextEditingController();

  var startDate = DateTime.now().obs;
  TextEditingController dateInput = TextEditingController();

  @override
  void onInit() {
    transfer.value = Get.arguments;
    loadAccounts();
    loadCurrentTransfer();
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
    fromSelectedAccount.value =
        accounts.singleWhere((element) => element.id == id);
    update();
  }

  updateInAccount(String id) {
    inSelectedAccount.value =
        accounts.singleWhere((element) => element.id == id);
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

  loadCurrentTransfer() {
    name.text = transfer.value.name!;
    amount.text = transfer.value.amount.toString();
    description.text = transfer.value.description!;
    fromSelectedAccount.value = transfer.value.fromAccount!;
    inSelectedAccount.value = transfer.value.inAccount!;
    processed.value = transfer.value.processed!;
    dateInput.text = DateFormat.yMd(Get.locale?.languageCode)
        .format(transfer.value.executionDate!);
    startDate.value = transfer.value.executionDate!;
  }

  updateTransfer() async {
    try {
      var value = double.tryParse(amount.text.trim());

      // if(fromSelectedAccount.value.balance! < value! ){
      //   DialogHelper.showSnackBar(title: "Error", message: "The Selected account don't have enough balance");
      //   return;
      // }
      // if(fromSelectedAccount.value.id == inSelectedAccount.value.id){
      //   DialogHelper.showSnackBar(title: "Error", message: "You can't tranfer to the same account");
      //   return;
      // }

      var data = Transfer(
              name: name.text.trim(),
              processed: processed.value,
              description: description.text.trim() ?? "",
              amount: double.tryParse(amount.text.trim()),
              executionDate: startDate.value,
              fromAccount: fromSelectedAccount.value,
              inAccount: inSelectedAccount.value)
          .toJson();


      dio.Response response = await _service.update(data, transfer.value.id!);

      if (response.statusCode == StatusCode.OK) {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appMessageUpdateCreatedText.tr,
          color: AppColorList.APPCOLOR022,
        );
        Get.offAllNamed(AppRoutes.HOME);
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }
}
