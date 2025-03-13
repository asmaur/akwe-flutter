import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poupey/src/exceptions/network_exceptions.dart';
import 'package:poupey/src/globals/app_authentication_service.dart';
import 'package:poupey/src/globals/app_premium_service.dart';
import 'package:poupey/src/helpers/dialog_helper.dart';
import 'package:poupey/src/models/marital_status.dart';
import 'package:poupey/src/models/user_data/user_data.dart';
import 'package:poupey/src/models/user_sex.dart';
import 'package:poupey/src/routes/app_pages.dart';
import 'package:poupey/src/services/networking/apiservice/user_service.dart';
import 'package:poupey/src/translations/translation_keys.dart' as translation;
import 'package:poupey/src/utils/marital_status_list.dart';
import 'package:poupey/src/utils/status_code.dart';
import 'package:poupey/src/utils/user_sex_list.dart';

class UserDataController extends GetxController {
  final _appAuthService = Get.find<AppAuthenticationService>();
  final premiumService = Get.find<AppPremiumService>();
  final _userService = UserService();
  late User? user;

  final sexList = getSexList();

  final maritalStatus = getMaritalStatusList();

  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var startDate = DateTime.now().obs;
  TextEditingController dateInput = TextEditingController();
  var children = 0.0.obs;
  var monthlyEarning = 100.0.obs;
  var selectedMarital = MaritalStatus(key: 13, name: translation.appUserDataMaritalSingle.tr,).obs;
  var selectedSex = UserSex(key: 3, name: translation.appUserDataSexMale.tr,).obs;
  var isLoading = true.obs;


  @override
  onInit() {
    super.onInit();
    user = _appAuthService.getCurrentUser();
    if (user == null) {
      Get.offAllNamed(Routes.WELCOME);
    }

    // selectedMarital(maritalStatus.first);
    // selectedSex(sexList.first);


    getUserProfile();


  }

  @override
  onClose(){
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    dateInput.dispose();
    super.onClose();
  }

  getUserProfile() async{
    try{
       dio.Response response = await _userService.getUserProfile();

       if(response.statusCode == StatusCode.OK){
         var appUser = UserData.fromJson(response.data);
         initializeData(appUser);
         Future.delayed(const Duration(seconds: 5));
       }
       isLoading.value = false;

    } on dio.DioException catch(e){
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }

  }


  initializeData(UserData appUser){
    //print(appUser.birthDate!.toIso8601String());
    firstName.text = appUser.firstName!;
    lastName.text = appUser.lastName!;
    email.text = appUser.email!;
    dateInput.text = appUser.birthDate == null ? "" : DateFormat("dd/MM/yyyy").format(appUser.birthDate!);
    startDate.value = appUser.birthDate ?? DateTime.now();
    children.value = appUser.children!;
    monthlyEarning.value = appUser.monthlyEarnings!;

    selectedMarital.value = maritalStatus.singleWhere((element) => element.key==appUser.maritalStatus?.key!); //appUser.maritalStatus!;
    selectedSex.value = sexList.singleWhere((element) => element.key==appUser.sex?.key!); //appUser.sex!;
  }


  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      locale: Get.locale,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: startDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != startDate.value) {
      startDate.value = pickedDate;
      //print(startDate.value.toString());
      dateInput.text = DateFormat("dd/MM/yyyy").format(pickedDate);
    } else {
      log("Date is not selected");
    }
  }

  setSelectedMarital(int key){
    selectedMarital(maritalStatus.singleWhere((MaritalStatus element) => element.key==key));
    update();
  }

  setSelectedSex(int key){
    selectedSex(sexList.singleWhere((UserSex element) => element.key==key));
    update();
  }

  updateUserProfile() async{
    DialogHelper.showLoading();
    try {
      var data = UserData(
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim() ?? user?.email,
        children: children.value,
        monthlyEarnings: monthlyEarning.value,
        maritalStatus: selectedMarital.value,
        sex: selectedSex.value,
        birthDate: startDate.value,
      ).toJson();
      print(data);
      dio.Response response = await _userService.updateUserProfile(data);

      if(response.statusCode == StatusCode.OK){
        DialogHelper.hideLoading();
        Get.offAllNamed(Routes.HOME);
      }


    }on dio.DioException catch(e){
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }

  }

}
