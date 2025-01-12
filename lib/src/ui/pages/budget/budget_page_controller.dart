import 'package:akwe/src/data/services/budget_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/budgets/budget.dart';
import 'package:akwe/src/models/budgets/budget_history.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;


class BudgetPageController extends GetxController{
  final BudgetService _service = BudgetService();

  var isLoading = true.obs;
  var budget = Budget().obs;
  var histories = <BudgetHistory>[].obs;

  var id = "".obs;

  @override
  void onInit() {
    id.value = Get.arguments;

    getBudget();
    super.onInit();
  }

  getBudget() async{
    try{
      dio.Response response = await _service.getBudgetDetail(id.value);

      if(response.statusCode == StatusCode.OK){
        budget.value = Budget.fromJson(response.data);
        print(budget.value.histories);
        isLoading.value = false;
      }


    }on dio.DioException catch(e){
      isLoading.value = false;
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }


}