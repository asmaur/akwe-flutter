import 'package:equatable/equatable.dart';

class AppBasicFilterItem extends Equatable {
  String? key;
  String? value;

  AppBasicFilterItem({this.key, this.value});

  @override
  // TODO: implement props
  List<Object?> get props => [key, value];
}