import 'dart:developer';

import 'package:akwe/src/data/services/account_service.dart';
import 'package:akwe/src/data/services/category_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class DashBoardController extends GetxController{
  var tabIndex = 0;
  var darkMode = false.obs;
  var selected = false.obs;

  @override
  void onInit() async {
    //requestNotificationPermission();
    initialize();
    super.onInit();
  }


  void changeTabIndex(int index){
    if(index > 4){

    }
    tabIndex = index;
    update();
  }

  void switchThemeMode(bool value){
    darkMode.value = value;
  }

  void initialize() async {
    try {
      final categoryService = CategoryService();
      final accountService = AccountService();
      // final categoryStorage = CategoryStorageService();
      // final accountStorage = AccountStorageService();

      final storage = StorageService();

      dio.Response accounts = await accountService.get();
      dio.Response categories = await categoryService.get();

      await storage.setList("accounts", accounts.data);
      await storage.setList("categories", categories.data);

      // accountStorage.setAccountList(accounts.data);
      // categoryStorage.setCategoryList(categories.data);
    } catch (e) {
      log(e.toString());
    }
  }


}