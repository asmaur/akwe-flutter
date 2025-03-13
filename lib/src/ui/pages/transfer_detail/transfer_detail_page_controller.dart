import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:akwe/src/data/services/transfer_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/transfers/transfer.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/colors_mapping.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;


class TransferDetailPageController extends GetxController {
  final TransferService _service = TransferService();

  var transfer = Transfer().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    loadCurrentTransfer(Get.arguments);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  loadCurrentTransfer(int id) async {
    try {
      dio.Response response = await _service.retrieve(id);

      if (response.statusCode == StatusCode.OK) {
        transfer.value = Transfer.fromJson(response.data);
      }
      isLoading.value = false;
    } on dio.DioException catch (e) {
      //DialogHelper.hideLoading();
      isLoading.value = false;
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  void executeCurrentTransfer() async{
    DialogHelper.showLoading();
    try{
      dio.Response response = await _service.process(transfer.value.id!);

      if(response.statusCode == StatusCode.OK){
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appMessageUpdateCreatedText.tr,
          color: AppColorList.APPCOLOR022,
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

  deleteTransfer(int id) async {
    final TransferService service = TransferService();
    DialogHelper.showLoading();
    try {
      dio.Response response = await service.delete(id);

      if (response.statusCode == StatusCode.NO_CONTENT) {
        //await _storageService.deleteAccount(id);
        DialogHelper.hideLoading();
        Get.offAllNamed(AppRoutes.HOME);
      }
    } on dio.DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }


  deleteCurrentTransfer(){
    DialogHelper.showErrorDialog(
      title: translation.appMessageConfirm.tr,
      description: translation.appMessageConfirmText
          .trParams({"name": "${transfer.value.name}"}),
      onConfirm: () => deleteTransfer(transfer.value.id!),
    );
  }

  addToCalendar() async{
    // final Event event = Event(
    //   title: routine.value.name!,
    //   description: routine.value.description,
    //   startDate: routine.value.expirationDate!,
    //   endDate: routine.value.expirationDate!,
    //   // iosParams: IOSParams(
    //   //   reminder: Duration(/* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
    //   //   //url: 'https://www.example.com', // on iOS, you can set url to your event.
    //   // ),
    //   androidParams: AndroidParams(
    //     emailInvites: [], // on Android, you can add invite emails to your event.
    //   ),
    // );
    // Add2Calendar.addEvent2Cal(event);

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
      if(value == null){ return;}

      final Event event = Event(
        title: transfer.value.name!,
        description: transfer.value.description,
        startDate: transfer.value.executionDate!.add(
            Duration(hours: value.hour, minutes: value.minute)),
        endDate: transfer.value.executionDate!.add(
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
