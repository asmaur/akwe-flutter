import 'package:akwe/src/translations/en.dart';
import 'package:akwe/src/translations/fr.dart';
import 'package:akwe/src/translations/pt.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': En().messages,
    'pt_BR': Pt().messages,
    'fr_FR': Fr().messages,
  };
}