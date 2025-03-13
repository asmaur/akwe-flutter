import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:akwe/src/constants/popup_menu.dart';
import 'package:akwe/src/data/services/transaction_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/pages/transaction_all/transaction_all_page_controller.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/app_transaction_export_header.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;


class TransactionFilterPageController extends GetxController {
  final _service = TransactionService();
  // final premiumService = Get.find<AppPremiumService>();
  var filterMenuItems = <AppBasicFilterItem>[
    AppBasicFilterItem(key: "ALL", value: translation.appFilterAllLabelText.tr),
    AppBasicFilterItem(
        key: "INCOME", value: translation.appFilterIncomesLabelText.tr),
    AppBasicFilterItem(
        key: "EXPENSE", value: translation.appFilterExpensesLabelText.tr)
  ];

  var selectedItem = AppBasicFilterItem(
          key: "ALL", value: translation.appFilterAllLabelText.tr)
      .obs;

  var allTransactions = <Transaction>[].obs;
  var filteredTransactions = <Transaction>[].obs;
  var isLoading = true.obs;

  var dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 1)),
  ).obs;

  @override
  void onInit() {
    loadCurrentMonthTransaction();
    super.onInit();
  }

  loadCurrentMonthTransaction() async {
    //DialogHelper.showLoading();
    try {
      List<dynamic> items;

      var response = await _service.getFilterTransaction('', '');
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
          description: errorMessage.message);
    }
  }

  filterTransactions(AppBasicFilterItem item) {
    switch (item.key) {
      case 'ALL':
        filteredTransactions.clear();
        filteredTransactions.addAll(allTransactions);
        return;
      case 'INCOME':
        filteredTransactions.clear();
        filteredTransactions.addAll(
          allTransactions.where((element) => element.income),
        );
        return;
      case 'EXPENSE':
        filteredTransactions.clear();
        filteredTransactions.addAll(
          allTransactions.where((element) => !element.income),
        );
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

  Future selectDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: Get.context!,
      locale: Get.locale,
      initialDateRange: dateRange.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (newDateRange == null) return;
    dateRange.value = newDateRange;
  }

  filterByDateRange() async {
    DialogHelper.showLoading();
    allTransactions.clear();
    filteredTransactions.clear();

    try {
      List<dynamic> items;

      var response = await _service.getFilterTransaction(
        dateRange.value.start.toIso8601String(),
        dateRange.value.end.toIso8601String(),
      );

      if (response.statusCode == StatusCode.OK) {
        items = response.data;
        print(items.length);
        if (items.isNotEmpty) {
          for (var item in items) {
            allTransactions.add(Transaction.fromJson(item));

            filteredTransactions.add(Transaction.fromJson(item));
          }
        }

        print(allTransactions.length);
        print(filteredTransactions.length);
      }

      DialogHelper.hideLoading();
    } on dio.DioException catch (e) {
      //isLoading.value = false;
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //
  //   return directory.path;
  // }

  Future getStoragePermission() async {
    if (Platform.isAndroid || Platform.isIOS) {
      var permission = await Permission.storage.request();
      if (permission == PermissionStatus.granted) {
      } else {
        log("Permission Denied");
        return;
      }
    }
  }

  // void exportToCSV() async {
  //   DialogHelper.showLoading();
  //   try {
  //     List<List<String>> listOfLists = [];
  //     List<String> header = getAppTransactionExportHeader();
  //     listOfLists.add(header);
  //
  //     for (var element in filteredTransactions) {
  //       List<String> item = [];
  //       item.add(element.code!);
  //       item.add(element.name!);
  //       item.add(element.totalItems.toString());
  //       item.add(element.totalPayed.toString());
  //       item.add(element.discount.toString());
  //       item.add(element.income
  //           ? translation.appTransactionExportBooleanTrue.tr
  //           : translation.appTransactionExportBooleanFalse.tr);
  //       item.add(element.paymentMethod!.value!);
  //       item.add(element.account!.name!);
  //       item.add(element.category!.name!);
  //       item.add(element.company?.description ?? "null");
  //       item.add(element.processed!
  //           ? translation.appTransactionExportBooleanTrue.tr
  //           : translation.appTransactionExportBooleanFalse.tr);
  //       item.add(DateFormat("dd/MM/yyyy").format(element.creationDate!));
  //       item.add(element.description ?? "null");
  //
  //       listOfLists.add(item);
  //     }
  //
  //     var csvData = const ListToCsvConverter().convert(listOfLists);
  //     //exportCSV.myCSV(header, listOfLists);
  //
  //     if (Platform.isAndroid ||
  //         Platform.isIOS ||
  //         Platform.isWindows ||
  //         Platform.isMacOS) {
  //       final bytes = utf8.encode(csvData);
  //       Uint8List bytes2 = Uint8List.fromList(bytes);
  //       MimeType type = MimeType.csv;
  //       final xFile = await FileSaver.instance.saveAs(
  //         name:
  //             'Poupey-${DateFormat("dd-MM-yyyy-HH-mm-ss").format(DateTime.now())}',
  //         bytes: bytes2,
  //         ext: 'csv',
  //         mimeType: type,
  //       );
  //       // if(sharing == true){
  //       //   final xFile = XFile.fromData(bytes2,mimeType: 'csv',name: 'CSV File',);
  //       //   await Share.shareXFiles([xFile]);
  //     }
  //     DialogHelper.hideLoading();
  //
  //     DialogHelper.showSnackBar(
  //       title: translation.appMessageSuccess.tr,
  //       message: translation.appFileExportedFileSuccessMessage.tr,
  //     );
  //
  //   } catch (e) {
  //     DialogHelper.hideLoading();
  //     print(e);
  //   }
  // }

  // void exportToExcel() async {
  //   DialogHelper.showLoading();
  //   await getStoragePermission();
  //   var sheetHeaders = getAppTransactionExportHeader();
  //   try {
  //     final excel = Excel.createExcel();
  //     final colIterableSheet = excel[excel.getDefaultSheet()!];
  //     //'Poupey-${DateFormat("dd-MM-yyyy").format(DateTime.now())}']; //excel.getDefaultSheet()!];
  //     int rows = 10;
  //     int colIndex = 0;
  //
  //     CellStyle cellStyle = CellStyle(
  //       bold: true,
  //       italic: true,
  //       textWrapping: TextWrapping.WrapText,
  //       fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
  //       rotation: 0,
  //     );
  //
  //     // sheetHeaders.forEach((colValue) {
  //     //   colIterableSheet.cell(CellIndex.indexByColumnRow(
  //     //     rowIndex: colIterableSheet.maxRows,
  //     //     columnIndex: colIterableSheet.maxCols,
  //     //   ))
  //     //     ..value = colValue;
  //     // });
  //
  //     sheetHeaders.asMap().forEach((index, colValue) {
  //       colIterableSheet
  //           .cell(CellIndex.indexByColumnRow(
  //             rowIndex: 0, //colIterableSheet.maxRows,
  //             columnIndex: index,
  //           ))
  //           .value = colValue;
  //     });
  //
  //     for (var row = 1; row < filteredTransactions.length + 1; row++) {
  //       sheetHeaders.asMap().forEach((index, colValue) {
  //         if (index == 0) {
  //           colIterableSheet
  //               .cell(
  //                 CellIndex.indexByColumnRow(
  //                   rowIndex: row, //colIterableSheet.maxRows,
  //                   columnIndex: index,
  //                 ),
  //               )
  //               .value = filteredTransactions[row - 1].code;
  //         }
  //         if (index == 1) {
  //           colIterableSheet
  //               .cell(
  //                 CellIndex.indexByColumnRow(
  //                   rowIndex: row, //colIterableSheet.maxRows,
  //                   columnIndex: index,
  //                 ),
  //               )
  //               .value = filteredTransactions[row - 1].name;
  //         }
  //         if (index == 2) {
  //           colIterableSheet
  //               .cell(
  //                 CellIndex.indexByColumnRow(
  //                   rowIndex: row, //colIterableSheet.maxRows,
  //                   columnIndex: index,
  //                 ),
  //               )
  //               .value = filteredTransactions[row - 1].totalItems;
  //         }
  //         if (index == 3) {
  //           colIterableSheet
  //               .cell(
  //                 CellIndex.indexByColumnRow(
  //                   rowIndex: row, //colIterableSheet.maxRows,
  //                   columnIndex: index,
  //                 ),
  //               )
  //               .value = filteredTransactions[row - 1].totalPayed;
  //         }
  //         if (index == 4) {
  //           colIterableSheet
  //               .cell(
  //                 CellIndex.indexByColumnRow(
  //                   rowIndex: row, //colIterableSheet.maxRows,
  //                   columnIndex: index,
  //                 ),
  //               )
  //               .value = filteredTransactions[row - 1].discount;
  //         }
  //         if (index == 5) {
  //           colIterableSheet
  //                   .cell(
  //                     CellIndex.indexByColumnRow(
  //                       rowIndex: row, //colIterableSheet.maxRows,
  //                       columnIndex: index,
  //                     ),
  //                   )
  //                   .value =
  //               filteredTransactions[row - 1].income
  //                   ? translation.appTransactionExportBooleanTrue.tr
  //                   : translation.appTransactionExportBooleanFalse.tr;
  //         }
  //         if (index == 6) {
  //           colIterableSheet
  //               .cell(
  //                 CellIndex.indexByColumnRow(
  //                   rowIndex: row, //colIterableSheet.maxRows,
  //                   columnIndex: index,
  //                 ),
  //               )
  //               .value = filteredTransactions[row - 1].paymentMethod?.value!;
  //         }
  //         if (index == 7) {
  //           colIterableSheet
  //               .cell(
  //                 CellIndex.indexByColumnRow(
  //                   rowIndex: row, //colIterableSheet.maxRows,
  //                   columnIndex: index,
  //                 ),
  //               )
  //               .value = filteredTransactions[row - 1].account?.name;
  //         }
  //         if (index == 8) {
  //           colIterableSheet
  //               .cell(
  //                 CellIndex.indexByColumnRow(
  //                   rowIndex: row, //colIterableSheet.maxRows,
  //                   columnIndex: index,
  //                 ),
  //               )
  //               .value = filteredTransactions[row - 1].category?.name;
  //         }
  //         if (index == 9) {
  //           colIterableSheet
  //                   .cell(
  //                     CellIndex.indexByColumnRow(
  //                       rowIndex: row, //colIterableSheet.maxRows,
  //                       columnIndex: index,
  //                     ),
  //                   )
  //                   .value =
  //               filteredTransactions[row - 1].company?.description ?? "null";
  //         }
  //         if (index == 10) {
  //           colIterableSheet
  //                   .cell(
  //                     CellIndex.indexByColumnRow(
  //                       rowIndex: row, //colIterableSheet.maxRows,
  //                       columnIndex: index,
  //                     ),
  //                   )
  //                   .value =
  //               filteredTransactions[row - 1].processed!
  //                   ? translation.appTransactionExportBooleanTrue.tr
  //                   : translation.appTransactionExportBooleanFalse.tr;
  //         }
  //         // if(index == 11) {
  //         //   colIterableSheet.cell(
  //         //     CellIndex.indexByColumnRow(
  //         //       rowIndex: row, //colIterableSheet.maxRows,
  //         //       columnIndex: index,
  //         //     ),
  //         //   ).value = DateFormat("dd/MM/yyyy").format(filteredTransactions[row - 1].emissionDate!);
  //         // }
  //         if (index == 11) {
  //           colIterableSheet
  //                   .cell(
  //                     CellIndex.indexByColumnRow(
  //                       rowIndex: row, //colIterableSheet.maxRows,
  //                       columnIndex: index,
  //                     ),
  //                   )
  //                   .value =
  //               DateFormat("dd/MM/yyyy")
  //                   .format(filteredTransactions[row - 1].creationDate!);
  //         }
  //         if (index == 12) {
  //           colIterableSheet
  //               .cell(
  //                 CellIndex.indexByColumnRow(
  //                   rowIndex: row, //colIterableSheet.maxRows,
  //                   columnIndex: index,
  //                 ),
  //               )
  //               .value = filteredTransactions[row - 1].description;
  //         }
  //       });
  //     }
  //
  //     var name =
  //         'Poupey-${DateFormat("dd-MM-yyyy-HH-mm-ss").format(DateTime.now())}';
  //
  //     String? path = await FileSaver.instance.saveAs(
  //       name: name,
  //       //'Poupey-${name}',
  //       //link:  linkController.text,
  //       bytes: Uint8List.fromList(excel.encode()!),
  //       ext: 'xlsx',
  //
  //       ///extController.text,
  //       mimeType: MimeType.microsoftExcel,
  //     );
  //
  //     // final appDocDir = await getApplicationDocumentsDirectory();
  //     // final appDocPath = appDocDir.path;
  //     // final file = File('$appDocPath/$name');
  //     // await OpenFile.open(file.path);
  //     //
  //     // log(path.toString());
  //     DialogHelper.hideLoading();
  //
  //     DialogHelper.showSnackBar(
  //       title: translation.appMessageSuccess.tr,
  //       message: translation.appFileExportedFileSuccessMessage.tr,
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void exportToPDF() {}

  void actionPopUpItemSelected(AppPopupExportMenu item) {
    // final premiumService = Get.find<AppPremiumService>();

    switch (item) {
      case AppPopupExportMenu.excel:

        // if(!premiumService.isPremium.value) {
        //   Get.toNamed(AppRoutes.USERPREMIUM);
        // }else {
        //   exportToExcel();
        // }
        return;
      case AppPopupExportMenu.pdf:
        // Navigator.push(
        //   Get.context!,
        //   MaterialPageRoute(builder: (context) => InvoicePage()),
        // );
        //InvoicePage();
        // if(!premiumService.isPremium.value) {
        //   AppAdManager().getNoRouteVideoInterstitialAd();
        //   Get.toNamed(Routes.EDITUSERGOAL, arguments: goal);
        // }else {
        //   //AppAdManager().getNoRouteVideoInterstitialAd();
        //   Get.toNamed(Routes.EDITUSERGOAL, arguments: goal);
        // }
        return;
      case AppPopupExportMenu.csv:
        // if(!premiumService.isPremium.value) {
        //   Get.toNamed(AppRoutes.USERPREMIUM);
        // }else {
        //   exportToCSV();
        // }
        return;
    }
  }


}
