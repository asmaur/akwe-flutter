import 'package:akwe/src/data/services/budget_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/budgets/budget.dart';
import 'package:akwe/src/models/budgets/budget_history.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;


class BudgetFullPageController extends GetxController with GetSingleTickerProviderStateMixin{
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'LEFT'),
    const Tab(text: 'RIGHT'),
  ];
  final BudgetService _service = BudgetService();
  late TabController tabController;
  var id = "".obs;
  var isLoading = true.obs;
  //var budget = Budget().obs;
  var histories = <BudgetHistory>[].obs;
  var budget = Budget(
    initialBalance: 0.0,
    balance: 0.0,
    expenses: 0.0,
    incomes: 0.0,
    histories: <BudgetHistory>[]
  ).obs;

  @override
  void onInit() {
    id.value = Get.arguments;
    tabController = TabController(vsync: this, length: myTabs.length);

    getBudget();

    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  getBudget() async{
    try{
      dio.Response response = await _service.getBudgetDetail(id.value);

      if(response.statusCode == StatusCode.OK){
        budget.value = Budget.fromJson(response.data);
        isLoading.value = false;
      }


    }on dio.DioException catch(e){
      isLoading.value = false;
      final errorMessage = DioExceptions.fromDioError(e);
      //DialogHelper.hideLoading();
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }

  destroyBudget() async{
    DialogHelper.showLoading();
    try{
      dio.Response response = await _service.destroy(budget.value.id);

      if(response.statusCode == StatusCode.NO_CONTENT){
        Get.offAllNamed(AppRoutes.HOME);
      }

    } on dio.DioException catch(e){
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }

  deleteBudget() async {
    DialogHelper.showErrorDialog(
        title: "",
        description: translation.userBudgetDeleteText.tr,
        onConfirm: () => destroyBudget()
    );
  }

}