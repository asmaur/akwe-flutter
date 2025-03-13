import 'package:akwe/src/data/services/planning_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/models/routines/routine.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/pages/planning_new/new_planning_page_controller.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:akwe/src/utils/payment_type_list.dart';
import 'package:akwe/src/utils/reminder_period_list.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;


class EditPlanningPageController extends GetxController{

  final StorageService _storageService = StorageService();
  // final AccountStorageService _accountStorageService = AccountStorageService();
  // final RoutineStorageService _routineStorageService = RoutineStorageService();
  final PlanningService _planningService = PlanningService();

  var accounts = <AppAccount>[].obs;
  var categories = <AppCategory>[].obs;
  var paymentType = PaymentType().obs; //713.obs;
  var selectedAccount = AppAccount().obs;  //0.obs;
  var selectedCategory = AppCategory().obs;
  var valueChanged = false.obs;
  var income = true.obs;
  var planType = PlanTypes.yes.obs;

  var name = TextEditingController();
  var startDate = DateTime.now().obs;
  var notifyDayBefore = 1.obs;
  var amount = TextEditingController(text: "0");
  var description = TextEditingController();
  TextEditingController dateInput = TextEditingController();

  final paymentTypes = getPaymentTypeList();
  final reminderPeriodList = getReminderPeriod();
  final locale = Get.deviceLocale;

  var routine = Routine(
    id: "",
    name: "",
    description: "",
    income: false,
    paymentType: 713,
    done: false,
    reminderDate: DateTime.now(),
    expirationDate: DateTime.now()
  ).obs;


  @override
  void onInit() {
    loadCategories();
    loadAccounts();
    routine.value = Get.arguments;

    loadCurrentRoutine();

    super.onInit();
  }

  @override
  onClose(){
    name.dispose();
    amount.dispose();
    description.dispose();
    dateInput.dispose();
    super.onClose();
  }

  chooseDate() async{
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
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

  updatePlanningType(PlanTypes value){
    planType.value = value;
    if(value == PlanTypes.yes){
      income.value = true;
    }else{
      income.value = false;
    }
    update();
  }

  loadCategories() async {
    try {
      var values = await _storageService.list("categories");
      if (values.isNotEmpty) {
        for (var element in values) {
          categories.add(AppCategory.fromJson(element));
        }
      }
    }on dio.DioException catch(e){
      //DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }

  loadAccounts() async {
    var values = await _storageService.list("accounts");
    if (values.isNotEmpty) {
      for (var element in values) {
        accounts.add(AppAccount.fromJson(element));
      }
    }
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
    return paymentTypes.singleWhere((element) => element.key==key);
  }

  loadCurrentRoutine(){
    if(routine.value.income!){ income.value = routine.value.income!; planType.value = PlanTypes.yes; }else{income.value = routine.value.income!; planType.value = PlanTypes.no;}
    name.text = routine.value.name!;
    description.text = routine.value.description ?? "";
    amount.text = routine.value.amount.toString();
    //notifyDayBefore.value = AppDateUtils().getDaysDifferenceBetween(routine.value.reminderDate!, routine.value.expirationDate!);
    dateInput.text = DateFormat("dd/MM/yyyy").format(routine.value.expirationDate!);
    startDate.value = routine.value.expirationDate!;
    selectedAccount.value = routine.value.account!;
    selectedCategory.value = routine.value.category!;
    paymentType.value = paymentTypes.singleWhere((element) => element.key == routine.value.paymentType);
  }

  updateCurrentRoutine() async{
    DialogHelper.showLoading();
    try{
      Map<String, dynamic> data = {};
      //data['id'] = routine.value.id;
      data['name'] = name.text.trim();
      data['description'] = description.text.trim();
      data['amount'] = double.tryParse(amount.text.removeAllWhitespace);
      data['reminder_date'] = startDate.value.add(Duration(days: -notifyDayBefore.value)).toIso8601String();
      data['expiration_date'] = startDate.value.toIso8601String();
      data['account_id'] = selectedAccount.value;
      data['category_id'] = selectedCategory.value;
      data['payment_method'] = paymentType.value;
      data['income'] = income.value;


      dio.Response response = await _planningService.update(routine.value.id!, data);

      if(response.statusCode == StatusCode.OK){
        // await _routineStorageService.updateRoutine(response.data, routine.value.id!);
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(title: translation.appMessageSuccess.tr, message: translation.appMessageUpdateSuccessText.tr);
        Get.offAllNamed(AppRoutes.HOME);
      }


    }on dio.DioException catch(e){
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }


}