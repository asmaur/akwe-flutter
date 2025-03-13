import 'package:akwe/src/constants/storage_items.dart';
import 'package:akwe/src/data/services/metric_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/accounts/app_account_metric.dart';
import 'package:akwe/src/models/app_chart_data.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/models/categories/app_category_metric.dart';
import 'package:akwe/src/models/companies/app_company_metric.dart';
import 'package:akwe/src/models/transactions/app_transaction_metric.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/app_color.dart';
import 'package:akwe/src/utils/app_color_list.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:dio/dio.dart' as dio;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class ReportPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final StorageService _storageService = StorageService();
  // final AccountStorageService _accountStorageService = AccountStorageService();
  final MetricService _service = MetricService();
  // final premiumService = Get.find<AppPremiumService>();

  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime.now().add(const Duration(days: -15)),
      end: DateTime.now());
  var startDate = TextEditingController();
  var endDate = TextEditingController();

  Future pickDateRange(context) async {
    if (true) {
      DialogHelper.showErrorDialog(
        title: translation.appGoPremiumTitle.tr,
        description: translation.appGoPremiumMetricFilterText.tr,
      );
      return;
    }

    DateTimeRange? newDateTimeRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateTimeRange,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (newDateTimeRange == null) return;
    dateTimeRange = newDateTimeRange;
    startDate.text = DateFormat("dd/MM/yyyy").format(dateTimeRange.start);
    endDate.text = DateFormat("dd/MM/yyyy").format(dateTimeRange.end);
  }

  var colorList = getAppColorList();

  final List<Tab> graphTabs = <Tab>[
    Tab(text: translation.appMetricPeriodicLabel.tr),
    Tab(text: translation.appMetricFlowLabel.tr),
  ];

  List<String> metricNavItems = [
    translation.appMetricExpenseByCategory.tr,
    translation.appMetricExpenseByAccount.tr,
    translation.appMetricExpenseByCompany.tr,
    translation.appMetricIncomeByCategory.tr,
    translation.appMetricIncomeByAccount.tr,
    //"Planejados vs",
    //"Orçamento em planejados",
    //"Orçameto em despesas por categoria",
    //"Orçameto em despesas por conta",
    //"Orçameto em despesas por empresas",
  ];

  List<String> fluxNavItems = [
    translation.appMetricExpensePerDay.tr,
    translation.appMetricIncomePerDay.tr,
    //'Orçamento vs despesa por dia',
  ];

  var accounts = <AppAccount>[].obs;
  var categories = <AppCategory>[].obs;
  var expenseByCategory = <AppCategoryMetric>[].obs;
  var expenseByAccount = <AppAccountMetric>[].obs;
  var incomeByCategory = <AppCategoryMetric>[].obs;
  var incomeByAccount = <AppAccountMetric>[].obs;
  var expenseByCompany = <AppCompanyMetric>[].obs;
  var expensePerDay = <AppTransactionMetric>[].obs;
  var incomePerDay = <AppTransactionMetric>[].obs;
  var chartData = <ChartData>[].obs;
  var lineChartInfo = <FlSpot>[].obs;

  final _random = Random();

  var selectedMetricItem = 0.obs;
  var selectedFluxItem = 1.obs;

  late TabController controller;

  @override
  void onInit() async {
    controller = TabController(vsync: this, length: graphTabs.length);
    loadCategories();
    loadAccounts();

    loadExpenseByCategory();
    loadExpensePerDay();

    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  loadCategories() async {
    try {
      var values = await _storageService.list(AppLocalStore.CATEGORYSTORE);
      if (values.isNotEmpty) {
        for (var element in values) {
          categories.add(AppCategory.fromJson(element));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  loadAccounts() async {
    var values = await _storageService.list(AppLocalStore.ACCOUNTSTORE);
      for (var element in values) {
        accounts.add(AppAccount.fromJson(element));
      }
    }

  loadExpenseByCategory() async {
    //DialogHelper.showLoading();
    try {
      dio.Response response = await _service.getExpenseByCategory();

      if (expenseByCategory.isEmpty) {
        if (response.statusCode == StatusCode.OK) {
          var items = response.data;
          print(items);

          items.forEach((item) =>
              expenseByCategory.add(AppCategoryMetric.fromJson(item)));

          var total = 0.0;
          for (var element in expenseByCategory) {
            total += element.value!;
          }

          for (var element in expenseByCategory) {
            var category = getCategoryName(element.categoryId);
            chartData.add(
              ChartData(
                name: category.name,
                value: element.value,
                percent: ((element.value! * 100) / total).toPrecision(2),
                color: category.color
                    .color, //Color.fromRGBO(_random.nextInt(255), _random.nextInt(255), _random.nextInt(255), 1)
              ),
            );
          }
        }
      } else {
        var total = 0.0;
        for (var element in expenseByCategory) {
          total += element.value!;
        }
        for (var element in expenseByCategory) {
          var category = getCategoryName(element.categoryId);

          chartData.add(
            ChartData(
              name: category.name,
              value: element.value,
              percent: ((element.value! * 100) / total).toPrecision(2),
              color: category.color
                  .color, //Color.fromRGBO(_random.nextInt(255), _random.nextInt(255), _random.nextInt(255), 1)
            ),
          );
        }
      }
    } on dio.DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  loadExpenseByAccount() async {
    DialogHelper.showLoading();
    try {
      dio.Response response = await _service.getExpenseByAccount();

      if (expenseByAccount.isEmpty) {
        if (response.statusCode == StatusCode.OK) {
          var items = response.data;

          items.forEach(
              (item) => expenseByAccount.add(AppAccountMetric.fromJson(item)));

          var total = 0.0;
          for (var element in expenseByAccount) {
            total += element.value!;
          }

          for (var element in expenseByAccount) {
            var account = getAccountName(element.accountId);
            chartData.add(
              ChartData(
                name: account.name,
                value: element.value,
                percent: ((element.value! * 100) / total).toPrecision(2),
                color: account.color.color,
              ),
            );
          }
          DialogHelper.hideLoading();
        }
      } else {
        var total = 0.0;
        for (var element in expenseByAccount) {
          total += element.value!;
        }

        for (var element in expenseByAccount) {
          var account = getAccountName(element.accountId);
          chartData.add(
            ChartData(
              name: account.name,
              value: element.value,
              percent: ((element.value! * 100) / total).toPrecision(2),
              color: account.color.color,
            ),
          );
        }
        DialogHelper.hideLoading();
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  loadIncomeByCategory() async {
    DialogHelper.showLoading();
    try {
      dio.Response response = await _service.getIncomeByCategory();

      if (incomeByCategory.isEmpty) {
        if (response.statusCode == StatusCode.OK) {
          var items = response.data;

          items.forEach(
              (item) => incomeByCategory.add(AppCategoryMetric.fromJson(item)));

          var total = 0.0;
          for (var element in incomeByCategory) {
            total += element.value!;
          }

          for (var element in incomeByCategory) {
            var category = getCategoryName(element.categoryId);
            chartData.add(
              ChartData(
                name: category.name,
                value: element.value,
                percent: ((element.value! * 100) / total).toPrecision(2),
                color: category.color
                    .color, //Color.fromRGBO(_random.nextInt(255), _random.nextInt(255), _random.nextInt(255), 1)
              ),
            );
          }
          DialogHelper.hideLoading();
        }
      } else {
        var total = 0.0;
        for (var element in incomeByCategory) {
          total += element.value!;
        }

        for (var element in incomeByCategory) {
          var category = getCategoryName(element.categoryId);

          chartData.add(
            ChartData(
              name: category.name,
              value: element.value,
              percent: ((element.value! * 100) / total).toPrecision(2),
              color: category.color
                  .color, //Color.fromRGBO(_random.nextInt(255), _random.nextInt(255), _random.nextInt(255), 1)
            ),
          );
        }
        DialogHelper.hideLoading();
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  loadIncomeByAccount() async {
    DialogHelper.showLoading();
    try {
      dio.Response response = await _service.getIncomeByAccount();

      if (incomeByAccount.isEmpty) {
        if (response.statusCode == StatusCode.OK) {
          var items = response.data;

          items.forEach(
              (item) => incomeByAccount.add(AppAccountMetric.fromJson(item)));

          var total = 0.0;
          for (var element in incomeByAccount) {
            total += element.value!;
          }

          for (var element in incomeByAccount) {
            var account = getAccountName(element.accountId);
            chartData.add(
              ChartData(
                name: account.name,
                value: element.value,
                percent: ((element.value! * 100) / total).toPrecision(2),
                color: account.color.color,
              ),
            );
          }
          DialogHelper.hideLoading();
        }
      } else {
        var total = 0.0;
        for (var element in incomeByAccount) {
          total += element.value!;
        }

        for (var element in incomeByAccount) {
          var account = getAccountName(element.accountId);
          chartData.add(
            ChartData(
              name: account.name,
              value: element.value,
              percent: ((element.value! * 100) / total).toPrecision(2),
              color: account.color.color,
            ),
          );
        }
        DialogHelper.hideLoading();
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  loadExpenseByCompany() async {
    DialogHelper.showLoading();
    try {
      dio.Response response = await _service.getExpenseByCompany();

      if (expenseByCompany.isEmpty) {
        if (response.statusCode == StatusCode.OK) {
          var items = response.data;

          items.forEach(
              (item) => expenseByCompany.add(AppCompanyMetric.fromJson(item)));

          var total = 0.0;
          for (var element in expenseByCompany) {
            total += element.value!;
          }

          for (var element in expenseByCompany) {
            chartData.add(
              ChartData(
                name: element.name,
                value: element.value,
                percent: ((element.value! * 100) / total).toPrecision(2),
                color: colorList[_random.nextInt(colorList.length)].color,
              ),
            );
          }
          DialogHelper.hideLoading();
        }
      } else {
        var total = 0.0;
        for (var element in expenseByCompany) {
          total += element.value!;
        }

        for (var element in expenseByCompany) {
          chartData.add(
            ChartData(
              name: element.name,
              value: element.value,
              percent: ((element.value! * 100) / total).toPrecision(2),
              color: colorList[_random.nextInt(colorList.length)].color,
            ),
          );
        }
        DialogHelper.hideLoading();
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  loadExpensePerDay() async {
    //DialogHelper.showLoading();
    try {
      dio.Response response = await _service.getExpensePerDay();

      if (expensePerDay.isEmpty) {
        if (response.statusCode == StatusCode.OK) {
          var items = response.data;

          items.forEach(
              (item) => expensePerDay.add(AppTransactionMetric.fromJson(item)));

          // var total = 0.0;
          // expenseByCompany.forEach((element) => total+=element.value!);

          for (var element in expensePerDay) {
            lineChartInfo.add(
              FlSpot(
                element.creationDate!,
                (element.value!).abs(),
              ),
            );
          }
          //DialogHelper.hideLoading();
        }
      } else {
        var total = 0.0;
        for (var element in expensePerDay) {
          total += element.value!;
        }

        for (var element in expensePerDay) {
          lineChartInfo.add(
            FlSpot(
              element.creationDate!,
              (element.value!).abs(),
            ),
          );
        }
        //DialogHelper.hideLoading();
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  loadIncomePerDay() async {
    DialogHelper.showLoading();
    try {
      dio.Response response = await _service.getIncomePerDay();

      if (incomePerDay.isEmpty) {
        if (response.statusCode == StatusCode.OK) {
          var items = response.data;

          items.forEach(
              (item) => incomePerDay.add(AppTransactionMetric.fromJson(item)));

          // var total = 0.0;
          // expenseByCompany.forEach((element) => total+=element.value!);

          for (var element in incomePerDay) {
            lineChartInfo.add(
              FlSpot(
                element.creationDate!,
                (element.value!).abs(),
              ),
            );
          }
          DialogHelper.hideLoading();
        }
      } else {
        var total = 0.0;
        for (var element in incomePerDay) {
          total += element.value!;
        }

        for (var element in incomePerDay) {
          lineChartInfo.add(
            FlSpot(
              element.creationDate!,
              (element.value!).abs(),
            ),
          );
        }
        DialogHelper.hideLoading();
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  getCategoryName(int? id) {
    return categories.singleWhere((element) => element.id == id);
  }

  getAccountName(int? id) {
    return accounts.singleWhere((element) => element.id == id);
  }

  getSelectedFilter(int selected) async {
    // if (selected != 0 && !premiumService.isPremium.value) {
    //   selected = 0;
    //   selectedMetricItem.value = 0;
    //   Get.toNamed(Routes.USERPREMIUM);
    // }

    switch (selected) {
      case 0:
        chartData.clear();
        await loadExpenseByCategory();
        break;
      case 1:
        chartData.clear();
        loadExpenseByAccount();
        break;
      case 2:
        chartData.clear();
        loadExpenseByCompany();
        break;
      case 3:
        chartData.clear();
        loadIncomeByCategory();
        break;
      case 4:
        chartData.clear();
        loadIncomeByAccount();
        break;
      default:
        chartData.clear();
        selectedMetricItem.value = 0;
        loadExpenseByCategory();
        break;
    }
  }

  getSelectedFluxFilter(int selected) async {
    // if (selected != 1 && !premiumService.isPremium.value) {
    //   selected = 1;
    //   selectedFluxItem.value = 1;
    //   Get.toNamed(Routes.USERPREMIUM);
    // }

    switch (selected) {
      case 0:
        lineChartInfo.clear();
        loadExpensePerDay();
        break;
      case 1:
        lineChartInfo.clear();
        loadIncomePerDay();
        break;
    }
  }

  getColor(int key) {
    return colorList
        .singleWhere((AppColor element) => element.key == key)
        .color;
  }
}
