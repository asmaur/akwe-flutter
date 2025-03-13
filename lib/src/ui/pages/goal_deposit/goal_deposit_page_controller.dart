import 'package:akwe/src/data/services/goal_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/goals/app_goal.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:mask/mask/mask.dart';
import 'package:reactive_forms/reactive_forms.dart';


class GoalDepositPageController extends GetxController{
  final StorageService _storageService = StorageService();
  final GoalService _goalService = GoalService();

  var currentGoal = AppGoal().obs;
  var amount = TextEditingController();
  var accounts = <AppAccount>[].obs;
  var selectedAccount = "".obs;

  final form = fb.group({
    "amount": FormControl<double>(value:0.00, validators: [Validators.required, Validators.min(10.0)]),
    "account_id": FormControl<String>(validators: [Validators.required]),
    "objective_id": FormControl<String>(validators: [Validators.required]),
  });


  @override
  void onInit() {
    currentGoal.value = Get.arguments;
    loadAccounts();
    form.control("objective_id").value = currentGoal.value.id!;
    super.onInit();
  }



  loadAccounts() async {
    var values = await _storageService.list("accounts");
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        accounts.add(AppAccount.fromJson(element));
      }
      selectedAccount.value = accounts.first.id!;
      form.control("account_id").value = selectedAccount.value;
    }
  }

  updateAccount(String id) {
    selectedAccount.value = id;
    update();
  }

  addGoalDeposit() async{
    print(form.value);
    // print(double.tryParse(form.control("amount").value.replaceAll("R\$", '').replaceAll(' ','')));
    // print(form.control("amount").value.trim());
    try{
        var data = {};
        // data['account_id'] = selectedAccount.value;
        // data['amount'] = double.tryParse(form.control("amount").value.replaceAll("R\$", '').replaceAll(' ',''));
        // data['objective_id'] = currentGoal.value.id!;
        // print(data);

        dio.Response response = await _goalService.deposit(data);

        if (response.statusCode == StatusCode.OK) {
          DialogHelper.hideLoading();
          DialogHelper.showSnackBar(
              title: translation.appMessageSuccess.tr,
              message: translation.appGoalDepositSuccessfullyMessage.tr,
          );
          Get.offAllNamed(AppRoutes.HOME);
        }

        }on dio.DioException catch (e) {
          DialogHelper.hideLoading();
          final errorMessage = DioExceptions.fromDioError(e);
          DialogHelper.showErrorDialog(
              title: translation.appMessageError.tr,
              description: errorMessage.message);
        }
  }


}