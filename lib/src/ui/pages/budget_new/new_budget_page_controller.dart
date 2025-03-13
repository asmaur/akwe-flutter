import 'package:akwe/src/data/services/budget_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/budgets/budget.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/pages/home/home_controller.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:reactive_forms/reactive_forms.dart';


class NewBudgetPageController extends GetxController {
  final BudgetService _budgetService = BudgetService();
  var budgetBalance = TextEditingController();

  final HomeController _homeController = Get.put(HomeController());

  var insertCurrentBalance = false.obs;

  final form = fb.group({
    "id": FormControl<String>(validators: [Validators.required]),
    "initial_balance": FormControl<double>(
    value: 0.0, validators: [Validators.required, Validators.min(10.0)]),
    "insert_balance": FormControl<bool>(value: false)
  });

  @override
  void onInit() {
    form.control("id").value = Get.arguments;
    super.onInit();
  }

  @override
  onClose(){
    // budgetBalance.dispose();
    super.onClose();
  }


  toggle() {
    insertCurrentBalance.value = !insertCurrentBalance.value;
    update();
  }

  createBudget() async {
    try {
      print(form.valid);
      // double? balance = double.tryParse(budgetBalance.text.trim().removeAllWhitespace);
      // var budget = Budget(
      //   id: Get.arguments,
      //   initialBalance: balance!,
      // ).toJson();
      // budget['insert_balance'] = insertCurrentBalance.value;
      Map<String, dynamic> data = form.value;

      dio.Response response = await _budgetService.updateMyBudget(data);

      if(response.statusCode == StatusCode.OK) {
        _homeController.budget.value = Budget.fromJson(response.data);
        Get.offAllNamed(AppRoutes.HOME);
      }

    } on dio.DioException catch(e){
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }
}
