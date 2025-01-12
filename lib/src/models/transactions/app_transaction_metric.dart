import 'package:intl/intl.dart';

class AppTransactionMetric{
  double? creationDate;
  String? stringDate;
  double? value;

  AppTransactionMetric({this.creationDate, this.stringDate, this.value});

  AppTransactionMetric.fromJson(Map<String, dynamic> json){
    value = json['value'];
    creationDate = DateTime.tryParse(json['date'])?.millisecondsSinceEpoch.toDouble();
    stringDate = DateFormat.yMEd().format(DateTime.tryParse(json['date'])!);
  }

}