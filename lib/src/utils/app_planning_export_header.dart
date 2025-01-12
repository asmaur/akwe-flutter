import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;


List<String> getAppPlanningExportHeader(){
  return [
    translation.appTransactionExportHeaderName.tr,
    translation.appTextFieldAmountLabel.tr,
    translation.appTransactionExportHeaderIncome.tr,
    translation.appTransactionExportHeaderPaymentMethod.tr,
    translation.appTransactionExportHeaderProcessed.tr,
    translation.appTransactionExportHeaderAccount.tr,
    translation.appTransactionExportHeaderCategory.tr,
    translation.appPlanningExportExpirationDate.tr,
    translation.appPlanningExportExecutionDate.tr,
    translation.appPlanningExportReminderDate.tr,
    translation.appTransactionExportHeaderCreationDate.tr,
    translation.appTransactionExportHeaderDescription.tr,
  ];
}