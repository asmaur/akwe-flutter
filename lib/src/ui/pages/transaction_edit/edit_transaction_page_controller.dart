import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/data/services/transaction_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:akwe/src/utils/payment_type_list.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:reactive_forms/reactive_forms.dart';


class EditTransactionPageController extends GetxController{

  var transaction = Transaction().obs;
  final StorageService _storageService = StorageService();
  // final AccountStorageService _accountStorageService = AccountStorageService();
  // final TransactionStorageService _transactionStorageService =
  // TransactionStorageService();
  final TransactionService _transactionService = TransactionService();
  TextEditingController dateInput = TextEditingController();
  var startDate = DateTime.now().obs;

  var accounts = <AppAccount>[].obs;
  var categories = <AppCategory>[].obs;
  var paymentType = PaymentType().obs; //713.obs;
  var selectedAccount = AppAccount().obs;  //0.obs;
  var selectedCategory = AppCategory().obs;
  var name = TextEditingController();
  var amount = TextEditingController(text: "0");
  var description = TextEditingController();
  var income = false.obs;
  final paymentTypes = getPaymentTypeList();

  final form = fb.group({
    'name': FormControl<String>(validators: [
      Validators.required,
      Validators.maxLength(20),
      Validators.minLength(5),
      // ShortFieldValidator()
    ]),
    'description': FormControl<String>(value: ""),
    'total_items': FormControl<int>(value: 1),
    'total_value': FormControl<double>(validators: [Validators.required, Validators.min(0.5)]),
    'total_payed': FormControl<double>(validators: [Validators.required]),
    'payment_method': FormControl<int>(validators: [Validators.required]),
    'account_id': FormControl<String>(validators: [Validators.required]),
    'category_id': FormControl<String>(validators: [Validators.required]),
    // 'discount': FormControl<int>(value: 0),
    'income': FormControl<bool>(value: false),
    // 'auto': FormControl<bool>(value: false),
    // 'planed': FormControl<bool>(value: false),
    // 'processed': FormControl<bool>(value: true),
    // 'creation_date': FormControl<DateTime>(value: DateTime.now(), validators: [Validators.required]),
  });



  @override
  void onInit() {
    transaction.value = Get.arguments;
    loadCategories();
    loadAccounts();
    loadCurrentTransaction();
    super.onInit();
  }

  @override
  void onClose(){
    name.dispose();
    amount.dispose();
    description.dispose();
    dateInput.dispose();
    super.onClose();
  }

  loadCurrentTransaction(){
    // name.text = transaction.value.name!;
    // amount.text = transaction.value.totalPayed.toString();
    // description.text = transaction.value.description!;
    // //print(transaction.value.toJson());
    selectedCategory.value = transaction.value.category!;
    selectedAccount.value = transaction.value.account!;
    paymentType.value = transaction.value.paymentMethod!;
    income.value = transaction.value.income;
    form.control("name").value = transaction.value.name!;
    form.control("total_items").value = transaction.value.totalItems!;
    form.control("total_value").value = transaction.value.totalValue!;
    form.control("total_payed").value = transaction.value.totalPayed;
    form.control("payment_method").value = paymentType.value.key!;
    form.control("account_id").value = selectedAccount.value.id!;
    form.control("category_id").value = selectedCategory.value.id!;
    form.control("description").value = transaction.value.description!;
    form.control("income").value = transaction.value.income;

  }

  loadCategories() async {
    var values = await _storageService.list("categories");
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        categories.add(AppCategory.fromJson(element));
      }
      //selectedCategory.value = categories.first;
    }
  }

  loadAccounts() async {
    var values = await _storageService.list("accounts");
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        accounts.add(AppAccount.fromJson(element));
      }
      //selectedAccount.value = accounts.first;
    }
  }

  updateAccount(String id) {
    selectedAccount.value = accounts.singleWhere((element) => element.id==id);
    form.control("account_id").value = selectedAccount.value.id!;
    update();
  }

  updateCategory(String id) {
    selectedCategory.value = categories.singleWhere((element) => element.id==id);
    form.control("category_id").value = selectedCategory.value.id!;
    update();
  }

  updatePaymentType(int key){
    paymentType.value = paymentTypes.singleWhere((element) => element.key==key);
    form.control("payment_method").value = paymentType.value.key!;
  }


  // chooseDate() async{
  //   DateTime? pickedDate = await showDatePicker(
  //     context: Get.context!,
  //     initialEntryMode: DatePickerEntryMode.calendarOnly,
  //     initialDate: startDate.value,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //
  //   if (pickedDate != null && pickedDate != startDate.value) {
  //     startDate.value = pickedDate;
  //     dateInput.text = DateFormat("dd/MM/yyyy").format(pickedDate);
  //
  //   } else {
  //     print("Date is not selected");
  //   }
  //
  // }

  updateTransaction() async{
    // DialogHelper.showLoading();
    form.control("total_value").value = form.control("total_payed").value;
    print(form.value);
    try {
      // var transactionName = name.text.trim();
      // var transactionDescription = description.text.trim();
      // var transactionValue = amount.text.trim().removeAllWhitespace;
      // var newTransaction = Transaction(
      //     name: transactionName,
      //     description: transactionDescription ?? "",
      //     paymentMethod: paymentType.value,
      //     totalPayed: double.parse(transactionValue),
      //     totalValue: double.parse(transactionValue),
      //     category: selectedCategory.value,
      //     account: selectedAccount.value,
      //     auto: false,
      //     processed: true,
      //     income: income.value,
      //     totalItems: transaction.value.totalItems,
      //     //creationDate: DateTime.now(),
      // ).toJson();
      if(!form.valid){
        form.markAllAsTouched();
      }
      form.control("total_value").value = form.control("total_payed").value;
      Map<String, dynamic> data = form.value;

      dio.Response response =
          await _transactionService.update(transaction.value.id!, data,);

      if (response.statusCode == StatusCode.OK) {
        // await _transactionStorageService.setTransaction(response.data);
        DialogHelper.hideLoading();

        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appMessageUpdateCreatedText.tr,
          color: AppColors.appDarkGreen,
        );
        Get.offAllNamed(AppRoutes.HOME);
      }


    } on dio.DioException catch(e){
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }

}