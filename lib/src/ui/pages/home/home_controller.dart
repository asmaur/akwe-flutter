import 'package:akwe/src/data/services/budget_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/budgets/budget.dart';
import 'package:akwe/src/models/budgets/budget_history.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class HomeController extends GetxController{
  final BudgetService _budgetService = BudgetService();

  var isLoading = true.obs;
  var budget = Budget(
    initialBalance: 0.0,
    balance: 0.0,
    expenses: 0.0,
    incomes: 0.0,
  ).obs;
  var showUpdate = false.obs;
  var positiveBalance = false.obs;

  // late BannerAd bannerAd;
  var isBannerAdReady = false.obs;
  var isEnabled = false.obs;


  // var id = "".obs;


  @override
  void onInit() {
    getMyBudget();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getMyBudget() async {
    try {
      dio.Response response = await _budgetService.getMyBudget();
      if (response.statusCode == StatusCode.OK) {
        var budgetFromResult = Budget.fromJson(response.data);

        budget.value = budgetFromResult;

        if (budget.value.initialBalance == 0.0) {
          showUpdate.value = true;
        }
        if (budget.value.balance! > 0.0) {
          positiveBalance.value = true;
        }
      }
    } on dio.DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  refreshMyBudget() async {
    DialogHelper.showLoading();
    try {
      dio.Response response = await _budgetService.getMyBudget();
      if (response.statusCode == 200) {
        var budgetFromResult = Budget.fromJson(response.data);
        budget.value = budgetFromResult;
        if (budget.value.initialBalance == 0.0) {
          showUpdate.value = true;
        }
      }

      DialogHelper.hideLoading();
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }



}