import 'package:get/get.dart';

class AppPremiumService extends GetxService{

  var isPremium = false.obs;

// final _storageService = AppPremiumStorage();
//
// @override
// onInit() async{
//   //PurchaseAPI().init();
//   updatePurchaseStatus();
//   readPremium();
//   super.onInit();
// }
//
//
// Future<void> setIsPremium(bool premium) async{
//   isPremium.value = premium;
//   await _storageService.enablePremium(premium);
// }
//
// Future<void> readPremium() async{
//   Future.delayed(const Duration(seconds: 2));
//   bool value = await _storageService.readPremium();
//   isPremium.value = value;
// }
//
// Future updatePurchaseStatus() async {
//   final purchaseInfo = await Purchases.getCustomerInfo();
//   final entitlements = purchaseInfo.entitlements.active.values.toList();
//   entitlements.isEmpty ? setIsPremium(false) : setIsPremium(entitlements.first.isActive);
// }


}