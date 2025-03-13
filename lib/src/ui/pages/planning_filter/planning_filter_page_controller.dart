import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:akwe/src/constants/popup_menu.dart';
import 'package:akwe/src/data/services/planning_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/routines/routine.dart';
import 'package:akwe/src/ui/pages/transaction_all/transaction_all_page_controller.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/app_planning_export_header.dart';
import 'package:akwe/src/utils/payment_type_list.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;


class PlanningFilterPageController extends GetxController{
  final PlanningService _service = PlanningService();
  // final premiumService = Get.find<AppPremiumService>();
  final paymentTypes = getPaymentTypeList();

  var filterMenuItems = <AppBasicFilterItem>[
    AppBasicFilterItem(key: "ALL", value: translation.appFilterAllLabelText.tr),
    AppBasicFilterItem(key: "INCOME", value: translation.appFilterIncomesLabelText.tr),
    AppBasicFilterItem(key: "EXPENSE", value: translation.appFilterExpensesLabelText.tr)
  ];

  var selectedItem = AppBasicFilterItem(key: "ALL", value: translation.appFilterAllLabelText.tr).obs;

  var allRoutines = <Routine>[].obs;
  var filteredRoutines = <Routine>[].obs;
  var isLoading = true.obs;

  var dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 1)),
  ).obs;

  @override
  onInit(){
    loadCurrentMonthRoutine();
    super.onInit();
  }


  updateSelectedFilter(AppBasicFilterItem item) {
    selectedItem.value = item;
    filterRoutines(item);
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
    allRoutines.clear();
    filteredRoutines.clear();

    try {
      List<dynamic> items;

      var response = await _service.getFilterRoutine(
         dateRange.value.start.toIso8601String(),
        dateRange.value.end.toIso8601String(),
      );


      if (response.statusCode == StatusCode.OK) {
        items = response.data;
        if (items.isNotEmpty) {

          for (var item in items) {
            allRoutines.add(Routine.fromJson(item));

            filteredRoutines.add(Routine.fromJson(item));
          }
        }

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

  loadCurrentMonthRoutine() async {
    try {
      List<dynamic> items;

      var response = await _service.getFilterRoutine('', '');//getAllCurrentMonthRoutine();
      if (response.statusCode == StatusCode.OK) {
        items = response.data;
        if (items.isNotEmpty) {
          allRoutines.clear();
          for (var item in items) {
            allRoutines.add(Routine.fromJson(item));
            filteredRoutines.clear();
            filteredRoutines.addAll(allRoutines);
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


  filterRoutines(AppBasicFilterItem item) {
    switch (item.key) {
      case 'ALL':
        filteredRoutines.clear();
        filteredRoutines.addAll(allRoutines);
        return;
      case 'INCOME':
        filteredRoutines.clear();
        filteredRoutines.addAll(
          allRoutines.where((element) => element.income!),);
        return;
      case 'EXPENSE':
        filteredRoutines.clear();
        filteredRoutines.addAll(
          allRoutines.where((element) => !element.income!),);
        return;
      default:
        filteredRoutines.clear();
        filteredRoutines.addAll(allRoutines);
        return;
    }
  }


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
  //     List<String> header = getAppPlanningExportHeader();
  //     listOfLists.add(header);
  //
  //     for (var element in filteredRoutines) {
  //       List<String> item = [];
  //       item.add(element.name!);
  //       item.add(element.amount.toString());
  //       item.add(element.income!
  //           ? translation.appTransactionExportBooleanTrue.tr
  //           : translation.appTransactionExportBooleanFalse.tr);
  //       item.add(paymentTypes.singleWhere((el) => el.key == element.paymentType).value);
  //       item.add(element.done!
  //           ? translation.appTransactionExportBooleanTrue.tr
  //           : translation.appTransactionExportBooleanFalse.tr);
  //       item.add(element.account!.name!);
  //       item.add(element.category!.name!);
  //
  //       item.add(DateFormat("dd/MM/yyyy").format(element.expirationDate!));
  //       item.add(element.executionDate != null ? DateFormat("dd/MM/yyyy").format(element.executionDate!) : "null");
  //       item.add(DateFormat("dd/MM/yyyy").format(element.reminderDate!));
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
  //         'Poupey-${DateFormat("dd-MM-yyyy-HH-mm-ss").format(DateTime.now())}',
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
  //   var sheetHeaders = getAppPlanningExportHeader();
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
  //     sheetHeaders.asMap().forEach((index, colValue) {
  //       colIterableSheet
  //           .cell(CellIndex.indexByColumnRow(
  //         rowIndex: 0, //colIterableSheet.maxRows,
  //         columnIndex: index,
  //       ))
  //           .value = colValue;
  //     });
  //
  //     for (var row = 1; row < filteredRoutines.length + 1; row++) {
  //       sheetHeaders.asMap().forEach((index, colValue) {
  //         if (index == 0) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value = filteredRoutines[row - 1].name;
  //         }
  //
  //         if (index == 1) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value = filteredRoutines[row - 1].amount;
  //         }
  //
  //         if (index == 2) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value =
  //           filteredRoutines[row - 1].income!
  //               ? translation.appTransactionExportBooleanTrue.tr
  //               : translation.appTransactionExportBooleanFalse.tr;
  //         }
  //
  //         if (index == 3) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value = paymentTypes.singleWhere((element) => element.key == filteredRoutines[row - 1].paymentType).value;
  //         }
  //
  //         if (index == 4) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value =
  //           filteredRoutines[row - 1].done!
  //               ? translation.appTransactionExportBooleanTrue.tr
  //               : translation.appTransactionExportBooleanFalse.tr;
  //         }
  //
  //
  //         if (index == 5) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value = filteredRoutines[row - 1].account?.name;
  //         }
  //
  //         if (index == 6) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value = filteredRoutines[row - 1].category?.name;
  //         }
  //
  //         if (index == 7) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value =
  //               DateFormat("dd/MM/yyyy")
  //                   .format(filteredRoutines[row - 1].expirationDate!);
  //         }
  //         if (index == 8) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value = filteredRoutines[row - 1].executionDate != null ?
  //               DateFormat("dd/MM/yyyy")
  //                   .format(filteredRoutines[row - 1].executionDate!) : "null";
  //         }
  //         if (index == 9) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value =
  //               DateFormat("dd/MM/yyyy")
  //                   .format(filteredRoutines[row - 1].reminderDate!);
  //         }
  //         if (index == 10) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value =
  //               DateFormat("dd/MM/yyyy")
  //                   .format(filteredRoutines[row - 1].creationDate!);
  //         }
  //         if (index == 11) {
  //           colIterableSheet
  //               .cell(
  //             CellIndex.indexByColumnRow(
  //               rowIndex: row, //colIterableSheet.maxRows,
  //               columnIndex: index,
  //             ),
  //           )
  //               .value = filteredRoutines[row - 1].description;
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
  //   } catch (e, stack) {
  //     print(stack);
  //   }
  // }

  void exportToPDF() {}

  void actionPopUpItemSelected(AppPopupExportMenu item) {
    // final premiumService = Get.find<AppPremiumService>();

    switch (item) {
      case AppPopupExportMenu.excel:
        // if(!premiumService.isPremium.value) {
        //   Get.toNamed(Routes.USERPREMIUM);
        // }else {
        //   exportToExcel();
        // }
        return;
      case AppPopupExportMenu.pdf:

        return;
      case AppPopupExportMenu.csv:
        // if(!premiumService.isPremium.value) {
        //   Get.toNamed(Routes.USERPREMIUM);
        // }else {
        //   exportToCSV();
        // }
        return;
    }
  }



}