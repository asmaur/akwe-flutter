import 'package:akwe/src/data/services/account_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class AccountPageController extends GetxController{
  final AccountService _accountService = AccountService();
  // final premiumService = Get.find<AppPremiumService>();
  final _storage = StorageService();
  var userAccounts = <AppAccount>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getUserAccounts();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getUserAccounts() async {
    try {
      await _storage.reset("accounts");

      List<dynamic> items;

      items = await _storage.list("accounts") ?? [];
      //print(items);

      if(items.isEmpty){
        var response = await _accountService.get();
        items = response.data;
        await _storage.setList("accounts", items);
      }

      userAccounts.clear();
      for (var item in items) {
        userAccounts.add(AppAccount.fromJson(item));
      }
      print(userAccounts);

      isLoading.value = false;
    } on DioException catch (e) {
      isLoading.value = false;
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }

  loadNewAccount(){
    // if(userAccounts.length < 2 && !premiumService.isPremium.value) {
    //   AppAdManager().getRouteOnlyInterstitialAd(Routes.NEWUSERACCOUNT);
    //   //Get.offNamed(Routes.NEWUSERACCOUNT);
    // }else if(premiumService.isPremium.value){
    //   //AppAdManager().getRouteOnlyInterstitialAd(Routes.NEWUSERACCOUNT);
    //   //Get.offNamed(Routes.USERPREMIUM);
    //   Get.offNamed(Routes.NEWUSERACCOUNT);
    // }
    // else{
    //   Get.offNamed(Routes.USERPREMIUM);
    // }
    Get.offNamed(AppRoutes.NEWUSERACCOUNT);
  }


}