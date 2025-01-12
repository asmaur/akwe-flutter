import 'dart:io';
import 'package:get/get.dart';
import 'package:in_date_utils/in_date_utils.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class AppDateUtils {

  String checkDate(DateTime date) {
    DateTime currentDate = DateTime.now();
    //initializeDateFormatting(Platform.localeName.substring(0, 2), "null");
    String lang = Platform.localeName.substring(0, 2);

    if ((date.year == currentDate.year) &&
        (date.month == currentDate.month) &&
        (date.day == currentDate.day)) {
      return translation.today.tr;
    }

    if ((date.year == currentDate.year) && (date.month == currentDate.month)) {
      if (currentDate.day - date.day == 1) {
        return translation.yesterday.tr;
      } else if (currentDate.day - date.day == -1) {
        return translation.tomorrow.tr;
      }
    }
    return DateFormat.MMMEd(Platform.localeName).format(date);
  }

  int weeksBetween(DateTime from, DateTime to) {
    from = DateTime.utc(from.year, from.month, from.day);
    to = DateTime.utc(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).ceil();
  }

  bool isToday(DateTime date){
    DateTime currentDate = DateTime.now();
    if ((date.year == currentDate.year) &&
        (date.month == currentDate.month) &&
        (date.day == currentDate.day)) {
        return true;
      }else {
      return false;
    }
  }
  
  bool isDateInWeek(DateTime date){
    final now = DTU.now();
    final currentWeekInt = (DTU.getDaysDifference(DateTime(DateTime.now().year, 1, 1), now)/7).ceil();
    final weekToDateInt = (DTU.getDaysDifference(DateTime(DateTime.now().year, 1, 1), date)/7).ceil();
    return currentWeekInt == weekToDateInt;

  }

  int getDaysDifference(DateTime date){
    if(date.compareTo(DateTime.now()) > 0){
      return DTU.getDaysDifference(date, DateTime.now());
    }else {
      return -DTU.getDaysDifference(date, DateTime.now());
    }
  }

  int getDaysDifferenceBetween(DateTime date, DateTime date2){
      return DTU.getDaysDifference(date,date2);
  }

}
