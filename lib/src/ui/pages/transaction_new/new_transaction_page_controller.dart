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
import 'package:akwe/src/validators/validators.dart';
import "../../../constants/storage_items.dart";
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:reactive_forms/reactive_forms.dart';

class NewTransactionPageController extends GetxController {
  final StorageService _storage = StorageService();
  final TransactionService _transactionService = TransactionService();
  List<PaymentType> paymentTypes = getPaymentTypeList();

  var income = false.obs;
  var filteredAccounts = <AppAccount>[].obs;
  var filteredCategories = <AppCategory>[].obs;
  var accounts = <AppAccount>[].obs;
  var categories = <AppCategory>[].obs;
  var paymentType = PaymentType().obs; //713.obs;
  // var selectedAccount = AppAccount().obs;  //0.obs;
  // var selectedCategory = AppCategory().obs; //0.obs;
  var selectedAccount = "".obs; //0.obs;
  var selectedCategory = "".obs;
  var selectedPaymentType = 713.obs;
  var name = TextEditingController();
  var amount = TextEditingController(text: "0");
  var description = TextEditingController();

  var startDate = DateTime.now().obs;
  TextEditingController dateInput = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));

  final form = fb.group({
    'name': FormControl<String>(validators: [
      Validators.required,
      Validators.maxLength(20),
      Validators.minLength(5),
      // ShortFieldValidator()
    ]),
    'description': FormControl<String>(value: ""),
    'total_items': FormControl<int>(value: 1),
    'total_value': FormControl<double>(
        validators: [Validators.required, Validators.min(0.5)]),
    'total_payed': FormControl<double>(validators: [Validators.required]),
    'payment_method': FormControl<int>(validators: [Validators.required]),
    'account_id': FormControl<String>(validators: [Validators.required]),
    'category_id': FormControl<String>(validators: [Validators.required]),
    'discount': FormControl<int>(value: 0),
    'income': FormControl<bool>(value: false),
    'auto': FormControl<bool>(value: false),
    'planed': FormControl<bool>(value: false),
    'processed': FormControl<bool>(value: true),
    'creation_date': FormControl<DateTime>(
        value: DateTime.now(), validators: [Validators.required]),
  });

  @override
  void onInit() {
    income.value = Get.arguments['income'];
    loadCategories();
    loadAccounts();
    setPaymentType();
    form.control("income").value = income.value;

    // loadFilteredAccounts();
    //
    // loadFilteredCategories();

    super.onInit();
  }

  @override
  void onClose() {
    name.dispose();
    amount.dispose();
    description.dispose();
    dateInput.dispose();
    super.onClose();
  }

  loadFilteredAccounts() {
    filteredAccounts
        .addAll(accounts); //.where((element) => element.isFund==income.value));
    //print(filteredAccounts.length);
    // selectedAccount.value = filteredAccounts.first;
  }

  loadFilteredCategories() {
    filteredCategories
        .addAll(categories.where((element) => element.income == income.value));
    //print(filteredCategories.length);
    // selectedCategory.value = filteredCategories.first;
  }

  setPaymentType() {
    selectedPaymentType.value = paymentTypes.first.key!;
    form.control("payment_method").value = selectedPaymentType.value;
  }

  loadCategories() async {
    var values = await _storage.list("categories");
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        categories.add(AppCategory.fromJson(element));
      }
      // loadFilteredCategories();
      selectedCategory.value = categories.first.id!;
      form.control('category_id').value = selectedCategory.value;
    }
  }

  loadAccounts() async {
    var values = await _storage.list("accounts");
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        accounts.add(AppAccount.fromJson(element));
      }
      //selectedAccount.value = accounts.first;
      // Future.delayed(const Duration(seconds: 2));
      // loadFilteredAccounts();
      selectedAccount.value = accounts.first.id!;
      form.control('account_id').value = selectedAccount.value;
    }
  }

  updateAccount(String id) {
    selectedAccount.value =
        accounts.singleWhere((element) => element.id == id).id!;
    update();
  }

  updateCategory(String id) {
    selectedCategory.value =
        categories.singleWhere((element) => element.id == id).id!;
    update();
  }

  updatePaymentType(int key) {
    paymentType.value =
        paymentTypes.singleWhere((element) => element.key == key);
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: startDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != startDate.value) {
      startDate.value = pickedDate;
      dateInput.text = DateFormat("dd/MM/yyyy").format(pickedDate);
    } else {
      print("Date is not selected");
    }
  }

  createNewTransactionOld() async {
    DialogHelper.showLoading();
    form.control("total_payed").value = form.control("total_value").value;
    print(form.valid);

    try {
      var transactionName = name.text.trim();
      var transactionDescription = description.text.trim();
      var transactionValue = amount.text.trim().removeAllWhitespace;
      var transaction = Transaction(
              name: transactionName,
              description: transactionDescription ?? "",
              paymentMethod: paymentType.value,
              totalItems: 1,
              totalPayed: double.parse(transactionValue),
              totalValue: double.parse(transactionValue),
              // category: selectedCategory.value,
              // account: selectedAccount.value,
              auto: false,
              processed: true,
              income: income.value,
              creationDate: DateTime.now())
          .toJson();

      transaction['creation_date'] = startDate.value.toIso8601String();

      dio.Response response =
          await _transactionService.createGenericTransaction(transaction);

      if (response.statusCode == StatusCode.CREATED) {
        await _storage.setList("transactions", response.data);
        DialogHelper.hideLoading();

        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appMessageUpdateCreatedText.tr,
          color: AppColors.appDarkGreen,
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

  createNewTransaction() async {
    try {
      DialogHelper.showLoading();
      form.control("total_payed").value = form.control("total_value").value;
      var pets = await _storage.list(AppLocalStore.TRANSACTIONSTORE);
      // print({...form.value, "creation_date": form
      //     .control("creation_date")
      //     .value
      //     .toIso8601String()});
      dio.Response response =
          await _transactionService.createGenericTransaction(
        {
          ...form.value,
          "creation_date":
              form.control("creation_date").value.toIso8601String(),
        },
      );

      if (response.statusCode == StatusCode.CREATED) {
        pets = [...pets, response.data];
        await _storage.setList("transactions", pets);
        DialogHelper.hideLoading();

        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appMessageUpdateCreatedText.tr,
          color: AppColors.appDarkGreen,
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
}
