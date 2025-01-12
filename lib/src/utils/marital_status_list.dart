import 'package:get/get.dart';
import 'package:akwe/src/models/marital_status.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;


getMaritalStatusList(){
  return [
    MaritalStatus(key: 13, name: translation.appUserDataMaritalSingle.tr,),
    MaritalStatus(key: 17, name: translation.appUserDataMaritalCouple.tr,),
    MaritalStatus(key: 21, name: translation.appUserDataMaritalMarried.tr,),
    MaritalStatus(key: 25, name: translation.appUserDataMaritalWidow.tr,),
    MaritalStatus(key: 29, name: translation.appUserDataSexOther.tr,),
  ];
}




