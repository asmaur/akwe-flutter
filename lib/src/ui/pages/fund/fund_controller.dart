import 'dart:io';

import 'package:akwe/src/data/services/account_service.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class FundController extends GetxController{
  final AccountService _accountService = AccountService();
  var isLoading = true.obs;
  var userFunds = <AppAccount>[].obs;

  @override
  void onInit() {
    getUserFunds();
    super.onInit();
  }

  Future<void> getUserFunds() async{
    try{
      var response = await _accountService.get();
      if(response.statusCode == 200) {
        var items = response.data;
        items.forEach(
                (item) => {
              if(item['is_fund'] == true){
                userFunds.add(AppAccount.fromJson(item))
              }
            }
        );
        isLoading.value = false;
      }

      if(response.statusCode == 400){
        isLoading.value = false;
        DialogHelper.showErrorDialog(description: "400");
      }

    } on DioException catch(e){
      isLoading.value = false;
      DialogHelper.showErrorDialog(description: e.message);
    } on SocketException {
      isLoading.value = false;
    }
  }

}