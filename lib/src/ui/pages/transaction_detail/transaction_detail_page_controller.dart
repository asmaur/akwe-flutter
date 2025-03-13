import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/data/services/transaction_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/app_item.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;


class TransactionDetailPageController extends GetxController {
  final StorageService _storageService = StorageService();
  final TransactionService _service = TransactionService();
  // final premiumService = Get.find<AppPremiumService>();
  var invoiceUrl = "".obs;
  var transaction = Transaction(auto: false, processed: false).obs;
  var items = <Item>[].obs;
  var showLink = false.obs;
  var showDescription = false.obs;
  var id = "".obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    id.value = Get.arguments;
    getTransaction(id.value);
    super.onInit();
  }

  getTransaction(String id) async {
    try {
      //var value = await _service.retrieve(id); //_storageService.getTransaction(id);
      dio.Response response = await _service.retrieve(id);
      transaction.value = Transaction.fromJson(response.data);
      transaction.value.invoiceUrl!.isEmpty
          ? showLink.value = false
          : showLink.value = true;
      transaction.value.description!.isEmpty
          ? showDescription.value = false
          : showDescription.value = true;

      isLoading.value = false;
    } on dio.DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      //DialogHelper.hideLoading();
      isLoading.value = false;
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  loadTransactionItems() async {
    DialogHelper.showLoading();
    try {
      dio.Response response = await _service.getTransactionItems(id.value);

      if (response.statusCode == StatusCode.OK) {
        var itemList = response.data;
        itemList.forEach((item) => {items.add(Item.fromJson(item))});

        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
          title: "",
          message: translation.appTransactionItemFoundText
              .trParams({"quantity": "${items.value.length}"}).trPlural(
                  translation.appTransactionItemFoundTextPlural.tr,
                  items.value.length),
          color: AppColors.appMidGreen,
        );
      }

      if (items.value.isEmpty) {
        DialogHelper.showSnackBar(
          title: "",
          message: translation.appTransactionNoItemFoundText.tr,
          color: AppColors.appYellow,
        );
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  deleteTransaction(String id) async {
    DialogHelper.showLoading();
    try {
      var response = await _service.destroy(id);

      if (response.statusCode == StatusCode.NO_CONTENT) {
        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appMessageUpdateDeleteText.tr,
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


  goToEditPage(){
    if (transaction.value.processed!) {
      // if(premiumService.isPremium.value) {
      //   Get.toNamed(
      //     Routes.EDITTRANSACTION,
      //     arguments: transaction.value,
      //   );
      // }else{
      //   Get.toNamed(Routes.USERPREMIUM);
      // }
      Get.toNamed(AppRoutes.EDITTRANSACTION, arguments: transaction.value,);
    } else {
      DialogHelper.showErrorDialog(
        title: translation.appMessageError.tr,
        description:
        translation.appTransactionInvoiceUnprocessedEditError.tr,
      );
    }
  }


}
