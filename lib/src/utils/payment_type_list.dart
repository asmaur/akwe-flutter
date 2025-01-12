import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:akwe/src/utils/payment_type.dart';


getPaymentTypeList() {
  var types = [
    PaymentType(key: 713, value: translation.userRoutinePaymentTypeCashText.tr),
    PaymentType(key: 715, value: translation.userRoutinePaymentTypeCreditText.tr),
    PaymentType(key: 717, value: translation.userRoutinePaymentTypeDebtText.tr),
    PaymentType(key: 745, value: translation.userRoutinePaymentTypePixText.tr),
    PaymentType(key: 719, value: translation.userRoutinePaymentTypeSalaryText.tr),
    PaymentType(key: 721, value: translation.userRoutinePaymentTypeExtraText.tr),
    PaymentType(key: 723, value: translation.userRoutinePaymentTypeLaborText.tr),
    PaymentType(key: 725, value: translation.userRoutinePaymentTypeCommissionText.tr),
    PaymentType(key: 727, value: translation.userRoutinePaymentTypeStudyText.tr),
    PaymentType(key: 729, value: translation.userRoutinePaymentTypeSalesText.tr),
    PaymentType(key: 731, value: translation.userRoutinePaymentTypeFreelancingText.tr),
    PaymentType(key: 733, value: translation.userRoutinePaymentTypeRentText.tr),
    PaymentType(key: 735, value: translation.userRoutinePaymentTypeFeeText.tr),
    PaymentType(key: 737, value: translation.userRoutinePaymentTypeRoyaltiesText.tr),
    PaymentType(key: 739, value: translation.userRoutinePaymentTypeProfitsText.tr),
    PaymentType(key: 741, value: translation.userRoutinePaymentTypeRetirementText.tr),
    PaymentType(key: 743, value: translation.userRoutinePaymentTypeMarketingText.tr),
  ];

  return types;
}