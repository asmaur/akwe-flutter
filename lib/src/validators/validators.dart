import 'package:reactive_forms/reactive_forms.dart';

class ShortFieldValidator extends Validator<dynamic> {
  @override
  Map<String, dynamic>? validate(AbstractControl control) {
    return control.isNotNull &&
        control.value is String &&
        control.value.length > 5
        ? null
        : {'requiredTrue': true};
  }
  
}