import 'package:akwe/src/data/services/budget_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/budgets/budget.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class BudgetListPageController extends GetxController{
  final budgetService = BudgetService();
  // final premiumService = Get.find<AppPremiumService>();
  var budgetItems = <Budget>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getBudgetList();
    super.onInit();
  }

  getBudgetList() async{
    try{
        dio.Response response = await budgetService.getBudgetList();
        if(response.statusCode == StatusCode.OK){
          var items = response.data;
          budgetItems.clear();
          items.forEach((item) => budgetItems.add(Budget.fromJson(item)));
          isLoading.value = false;
        }
    } on dio.DioException catch(e){
      isLoading.value = false;
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }

}