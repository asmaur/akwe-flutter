import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

List<String> getAppTransactionExportHeader(){
  return [
    translation.appTransactionExportHeaderCode.tr,
    translation.appTransactionExportHeaderName.tr,
    translation.appTransactionExportHeaderTotalItems.tr,
    translation.appTransactionExportHeaderTotalPayed.tr,
    translation.appTransactionExportHeaderDiscount.tr,
    translation.appTransactionExportHeaderIncome.tr,
    translation.appTransactionExportHeaderPaymentMethod.tr,
    translation.appTransactionExportHeaderAccount.tr,
    translation.appTransactionExportHeaderCategory.tr,
    translation.appTransactionExportHeaderCompany.tr,
    translation.appTransactionExportHeaderProcessed.tr,
    //translation.appTransactionExportHeaderEmissionDate.tr,
    translation.appTransactionExportHeaderCreationDate.tr,
    translation.appTransactionExportHeaderDescription.tr,

  ];
}