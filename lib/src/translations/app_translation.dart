import 'package:akwe/src/translations/en.dart';
import 'package:akwe/src/translations/es.dart';
import 'package:akwe/src/translations/fr.dart';
import 'package:akwe/src/translations/pt.dart';
import 'package:akwe/src/translations/sw.dart';

// import 'translation_keys.dart' as translation;

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationKeys = {
    "en": En().messages,
    "pt": Pt().messages,
    "es": Es().messages,
    "fr": Fr().messages,
    "sw": Sw().messages,
  };
}

