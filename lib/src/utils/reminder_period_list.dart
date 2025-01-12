import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class ReminderPeriod{
  String label;
  int period;

  ReminderPeriod(this.label, this.period);
}


getReminderPeriod(){
  return [
    ReminderPeriod(translation.appOneDay.tr, 1),
    ReminderPeriod(translation.appThreeDays.tr, 3),
    ReminderPeriod(translation.appSevenDays.tr, 7),
  ];
}