import 'package:akwe/src/data/services/transaction_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class AppBasicFilterItem extends Equatable {
  String? key;
  String? value;

  AppBasicFilterItem({this.key, this.value});

  @override
  // TODO: implement props
  List<Object?> get props => [key, value];
}

class TransactionAllPageController extends GetxController {
  final _service = TransactionService();
  var filterMenuItems = <AppBasicFilterItem>[
    AppBasicFilterItem(key: "ALL", value: "Transactions"),
    AppBasicFilterItem(key: "INCOME", value: "Incomes"),
    AppBasicFilterItem(key: "EXPENSE", value: "Expenses")
  ];

  var selectedItem = AppBasicFilterItem(key: "ALL", value: "Transactions").obs;

  var allTransactions = <Transaction>[];
  var filteredTransactions = <Transaction>[];
  var isLoading = true.obs;

  @override
  void onInit() {
    loadCurrentMonthTransaction();
    super.onInit();
  }


  loadCurrentMonthTransaction() async {
    //DialogHelper.showLoading();
    try {
      List<dynamic> items;

      var response = await _service.getCurrentMonthTransaction();
      if (response.statusCode == StatusCode.OK) {
        items = response.data;
        if (items.isNotEmpty) {

          allTransactions.clear();
          for (var item in items) {
            allTransactions.add(Transaction.fromJson(item));
            filteredTransactions.clear();
            filteredTransactions.addAll(allTransactions);
          }
        }
      }

      isLoading.value = false;
    } on dio.DioException catch (e) {
      isLoading.value = false;
      //DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message,);
    }
  }

  filterTransactions(AppBasicFilterItem item){
    switch (item.key){
      case 'ALL':
        filteredTransactions.clear();
        filteredTransactions.addAll(allTransactions);
        return;
      case 'INCOME':
        filteredTransactions.clear();
        filteredTransactions = allTransactions.where((element) => element.income).toList();
        return;
      case 'EXPENSE':
        filteredTransactions.clear();
        filteredTransactions = allTransactions.where((element) => !element.income).toList();
        return;
      default:
        filteredTransactions.clear();
        filteredTransactions.addAll(allTransactions);
        return;
    }
  }

  updateSelectedFilter(AppBasicFilterItem item) {
    selectedItem.value = item;
    filterTransactions(item);
  }


}
