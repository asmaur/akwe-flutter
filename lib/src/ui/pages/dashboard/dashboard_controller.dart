import 'package:akwe/src/routes/app_pages.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController{
  var tabIndex = 0;
  var darkMode = false.obs;
  var selected = false.obs;

  void changeTabIndex(int index){
    if(index > 4){

    }
    tabIndex = index;
    update();
  }

  void switchThemeMode(bool value){
    darkMode.value = value;
  }

}