import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:akwe/src/data/services/planning_service.dart';
import 'package:akwe/src/data/services/transaction_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/routines/routine.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class PlanningDetailPageController extends GetxController {
  final StorageService _storageService = StorageService();
  // final TransactionStorageService _transactionStorageService =
  //     TransactionStorageService();
  final TransactionService _service = TransactionService();
  final PlanningService _planningService = PlanningService();
  // final premiumService = Get.find<AppPremiumService>();
  var isLoading = true.obs;
  var id = "".obs;
  var description = TextEditingController();

  var routine = Routine(
          name: "",
          description: "",
          income: false,
          amount: 0.0,
          paymentType: 713,
          //color: "",
          expirationDate: DateTime.now(),
          executionDate: DateTime.now(),
          reminderDate: DateTime.now(),
          done: false)
      .obs;

  @override
  void onInit() {
    id.value = Get.arguments;
    getCurrentRoutine();
    super.onInit();
  }

  getCurrentRoutine() async {
    //isLoading.value = true;
    routine.value =
        Routine.fromJson(await _storageService.retrieve("routines", id.value));
    description.text = routine.value.description ?? "";

    isLoading.value = false;
  }

  executeCurrentRoutine() async {
    DialogHelper.showLoading();
    try {
      if (id.value == 0) {
        throw Exception("ValueError");
      }

      dio.Response response =
          await _service.executeNewRoutine({"id": id.value});
      if (response.statusCode == StatusCode.CREATED) {
        DialogHelper.hideLoading();
        // await _transactionStorageService
        //     .setTransaction(response.data['transaction']);
        // await _storageService.updateRoutine(response.data['routine'], id.value);

        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appMessageUpdateSuccessText.tr,
          duration: 5,
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

  destroyRoutine() async {
    DialogHelper.showLoading();
    try {
      if (id.value == "") {
        throw Exception("ValueError");
      }
      dio.Response response = await _planningService.delete(id.value);

      if (response.statusCode == StatusCode.NO_CONTENT) {
        // await _storageService.delete(id.value);
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
            message: translation.appMessageUpdateDeleteText.tr,
            title: translation.appMessageSuccess.tr);
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

  deleteRoutine() async {
    DialogHelper.showErrorDialog(
        title: "",
        description: translation.appRoutineDeleteConfirmMessage.tr,
        onConfirm: () => destroyRoutine());
  }

  addToCalendar() async{
    Future<TimeOfDay?> selectedTime24Hour = showTimePicker(
      context: Get.context!,
      cancelText: translation.appCancelButtonLabel.tr,
      helpText: translation.appSelectTime.tr,
      initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );


    selectedTime24Hour.then((value) async{

        final Event event = Event(
          title: routine.value.name!,
          description: routine.value.description,
          startDate: routine.value.reminderDate!.add(
              Duration(hours: value!.hour, minutes: value.minute)),
          endDate: routine.value.reminderDate!.add(
              Duration(hours: value.hour, minutes: value.minute)),
          // iosParams: IOSParams(
          //   reminder: Duration(/* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
          //   //url: 'https://www.example.com', // on iOS, you can set url to your event.
          // ),
          androidParams: const AndroidParams(
            emailInvites: [
            ], // on Android, you can add invite emails to your event.
          ),
        );

        //await _planningService.addToCalendar(routine.value.id);

        Add2Calendar.addEvent2Cal(event);

    });

  }

}
