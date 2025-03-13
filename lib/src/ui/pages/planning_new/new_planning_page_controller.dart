import 'dart:developer';

import 'package:akwe/src/data/services/planning_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:akwe/src/utils/payment_type_list.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

enum PlanTypes { yes, no }

class NewPlanningController extends GetxController {
  final StorageService _storageService = StorageService();
  // final AccountStorageService _accountStorageService = AccountStorageService();
  // final RoutineStorageService _routineStorageService = RoutineStorageService();
  final PlanningService _planningService = PlanningService();

  var accounts = <AppAccount>[].obs;
  var categories = <AppCategory>[].obs;
  var paymentType = PaymentType().obs;
  var selectedAccount = AppAccount().obs;
  var selectedCategory = AppCategory().obs;
  final paymentTypes = getPaymentTypeList();

  var income = true.obs;
  var planType = PlanTypes.yes.obs;

  var name = TextEditingController();
  var frequency = TextEditingController(text: "1");
  var repeatEvery = TextEditingController(text: "1");
  var startDate = DateTime.now().add(const Duration(days: 1)).obs;
  var notifyDayBefore = 1.obs;
  var amount = TextEditingController(text: "0");
  var description = TextEditingController();
  TextEditingController dateInput = TextEditingController(text: DateFormat("dd/MM/yyyy").format(DateTime.now()));

  @override
  void onInit() {
    loadCategories();
    loadAccounts();
    initializePaymentType();
    super.onInit();
  }

  @override
  void onClose(){
    name.dispose();
    frequency.dispose();
    repeatEvery.dispose();
    amount.dispose();
    description.dispose();
    dateInput.dispose();
    super.onClose();
  }


  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      locale: Get.locale,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: startDate.value,
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != startDate.value) {
      startDate.value = pickedDate;
      //print(startDate.value.toString());
      dateInput.text = DateFormat("dd/MM/yyyy").format(pickedDate);
    } else {
      log("Date is not selected");
    }
  }

  createNewPlanning() async {
    DialogHelper.showLoading("Processing");
    try {
      Map<String, dynamic> routine = {};
      var frequencyValue = int.parse(frequency.text.trim());
      //int pauseTime;

      routine['frequency'] = frequencyValue;
      routine['repeat_every'] = int.parse(repeatEvery.text.trim());
      routine['name'] = name.text.trim();
      routine['description'] = description.text.trim();
      routine['income'] = income.value;
      routine['payment_method'] = paymentType.value.key;
      routine['category_id'] = selectedCategory.value.id;
      routine['account_id'] = selectedAccount.value.id;
      routine['notify_day_before'] = notifyDayBefore.value;
      routine['amount'] = double.parse(amount.text.trim().removeAllWhitespace);
      routine['start_date'] = startDate.value.toIso8601String();


      dio.Response response = await _planningService.createNewPlanning(routine);

      if (response.statusCode == StatusCode.OK) {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appRoutineProcessingMessage.tr,
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

  updatePlanningType(PlanTypes value) {
    planType.value = value;
    if (value == PlanTypes.yes) {
      income.value = true;
    } else {
      income.value = false;
    }
    update();
  }

  loadCategories() async {
    var values = await _storageService.list("categories");
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        categories.add(AppCategory.fromJson(element));
      }
      selectedCategory.value = categories.first;
    }
  }

  loadAccounts() async {
    var values = await _storageService.list("accounts");
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        accounts.add(AppAccount.fromJson(element));
      }
      selectedAccount.value = accounts.first;

    }
  }

  initializePaymentType(){
    paymentType.value = paymentTypes[0];
  }

  updateAccount(String id) {
    selectedAccount.value = accounts.singleWhere((element) => element.id==id);
    update();
  }

  updateCategory(String id) {
    selectedCategory.value = categories.singleWhere((element) => element.id==id);
    update();
  }

  updatePaymentType(int key){
    paymentType.value = paymentTypes.singleWhere((element) => element.key==key);
  }
  
}
