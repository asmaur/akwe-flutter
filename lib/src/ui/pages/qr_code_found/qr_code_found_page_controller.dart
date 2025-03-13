import 'package:akwe/src/data/services/transaction_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/app_invoise_host.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:akwe/src/utils/payment_type_list.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:dio/dio.dart' as dio;

class QrCodeFoundPageController extends GetxController{
  // final CategoryStorageService _categoryStorageService =
  // CategoryStorageService();
  // final AccountStorageService _accountStorageService = AccountStorageService();
  // final TransactionStorageService _transactionStorageService =
  // TransactionStorageService();
  final TransactionService _transactionService = TransactionService();
  final paymentTypes = getPaymentTypeList();
  final StorageService _storageService = StorageService();

  //var income = false.obs;
  var accounts = <AppAccount>[].obs;
  var categories = <AppCategory>[].obs;
  var paymentType = PaymentType().obs; //713.obs;
  var selectedAccount = "".obs;  //0.obs;
  var selectedCategory = "".obs;
  var link = "".obs;
  var selectedPaymentType = 713.obs;

  final form = fb.group({
    "name": FormControl<String>(value: translation.appTransactionDefaultName.tr),
        // validators: [Validators.required, Validators.minLength(5), Validators.maxLength(20)]),
    "invoice_url": FormControl<String>(validators: [Validators.required,]),
    "account_id": FormControl<String>(validators: [Validators.required,]),
    "category_id": FormControl<String>(validators: [Validators.required,]),
    "payment_method": FormControl<int>(validators: [Validators.required,]),
    "processed": FormControl<bool>(value: false),
    "auto": FormControl<bool>(value: true),
    "total_items": FormControl<int>(value: 1)
  });



  @override
  void onInit() {
    loadCategories();
    loadAccounts();
    link.value = Get.arguments;
    initializePaymentType();
    form.control("invoice_url").value = link.value;
    super.onInit();
  }

  loadCategories() async {
    var values = await _storageService.list("categories");
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        categories.add(AppCategory.fromJson(element));
      }
      // selectedCategory.value = categories.first;
      selectedCategory.value = categories.first.id!;
      form.control('category_id').value = selectedCategory.value;
    }
  }

  loadAccounts() async {
    var values = await _storageService.list("accounts");
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        accounts.add(AppAccount.fromJson(element));
      }
      selectedAccount.value = accounts.first.id!;
      form.control('account_id').value = selectedAccount.value;
    }
  }

  initializePaymentType(){
    // paymentType.value = paymentTypes[0];
    selectedPaymentType.value = paymentTypes.first.key!;
    form.control("payment_method").value = selectedPaymentType.value;
  }

  updateAccount(String id) {
    selectedAccount.value = accounts.singleWhere((element) => element.id==id).id!;
    update();
  }

  updateCategory(String id) {
    selectedCategory.value = categories.singleWhere((element) => element.id==id).id!;
    update();
  }

  createNewTransaction() async {
    DialogHelper.showLoading();
    try {
      if (validateInvoiceLink()) {
        // var transaction = Transaction(
        //   name: translation.appTransactionDefaultName.tr,
        //   invoiceUrl: link.value,
        //   totalItems: 1,
        //   paymentMethod: paymentType.value,
        //   processed: false,
        //   auto: true,
        //   // category: selectedCategory.value,
        //   // account: selectedAccount.value,
        // )
        //     .toJson();
        // transaction['category'] = selectedCategory.value;
        // transaction['account'] = selectedAccount.value;

        if(!form.valid){
          form.markAllAsTouched();
          return;
        }
        Map<String, dynamic> data = form.value;
        dio.Response response =
        await _transactionService.createInvoiceTransaction(data);

        if (response.statusCode == StatusCode.CREATED) {
          DialogHelper.hideLoading();
          // _transactionStorageService.setTransaction(response.data);
          DialogHelper.showSnackBar(
              title: translation.appMessageSuccess.tr,
              message: translation.appMessageUpdateCreatedText.tr);
          Get.offNamed(AppRoutes.HOME);
        }
      } else {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
            title: translation.appMessageError.tr,
            message: translation.appInvalidLinkMessage.tr,
            isDismissible: false);
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  validateInvoiceLink() {
    var hostList = getInvoiceHost();
    var currentHost = Uri.parse(link.value).host;
    bool valid = false;
    for (final host in hostList) {
      if (host == currentHost) {
        valid = true;
      }
    }
    return valid;
  }

  updatePaymentType(int key){
    return paymentTypes.singleWhere((element) => element.key==key);
  }

}