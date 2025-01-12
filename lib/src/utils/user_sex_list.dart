import 'package:get/get.dart';
import 'package:akwe/src/models/user_sex.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;


getSexList(){
  return [
    UserSex(key: 3, name: translation.appUserDataSexMale.tr,),
    UserSex(key: 7, name: translation.appUserDataSexFemale.tr,),
    UserSex(key: 9, name: translation.appUserDataSexOther.tr,),
  ];
}



