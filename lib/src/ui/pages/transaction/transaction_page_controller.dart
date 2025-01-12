import 'package:akwe/src/data/services/transaction_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class TransactionPageController extends GetxController{
  final TransactionService _service = TransactionService();
  // final TransactionStorageService _storageService = TransactionStorageService();
  // final _premiumService = Get.find<AppPremiumService>();

  var isLoading = true.obs;
  var transactions = <Transaction>[].obs;

  @override
  void onInit() {
    getCurrentTransaction();
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


  Future<void> getCurrentTransaction() async {
    //DialogHelper.showLoading();
    try {
      //DialogHelper.showLoading();

      // await _storageService.deleteTransactionList();
      // var storeTransactionList = await _storageService.getTransactionList();
      List<dynamic> items;

      var response = await _service.getCurrentMonthTransaction();
      items = response.data;

      if (items.isNotEmpty) {
        transactions.clear();
        for (var item in items) {
          transactions.add(Transaction.fromJson(item));
        }
      }

      //isLoading.value = false;
      //DialogHelper.hideLoading();

    } on dio.DioException catch(e){
      //DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }


}