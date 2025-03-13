import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poupey/src/services/storage/preference_storage_service.dart';
import 'package:poupey/src/utils/app_locales.dart';
import 'package:poupey/src/utils/app_theme_list.dart';
import 'package:poupey/src/translations/translation_keys.dart' as translation;

class PreferenceController extends GetxController {
  final service = PreferenceStorageService();

  chooseLanguage(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            translation.appThemeChooseLanguageTitle.tr,
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    appLocales[index]['name'],
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 14),
                  ),
                  onTap: () {
                    Get.updateLocale(appLocales[index]['locale']);
                    service.setUserLanguage(index);
                    Get.back();
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.black,
                );
              },
              itemCount: appLocales.length,
            ),
          ),
        );
      },
    );
  }

  getFullLanguage(String lang) {
    switch (lang) {
      case 'pt':
        return 'Português';
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'sw':
        return 'Swahili';
      default:
        return "Undefined";
    }
  }

  chooseTheme(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            translation.appThemeChooseThemeTitle.tr,
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    appTheme[index]['name'],
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 14),
                  ),
                  onTap: () {
                    Get.changeThemeMode(
                      appTheme[index]['value'] == 'light'
                          ? ThemeMode.light
                          : ThemeMode.dark,
                    );
                    service.setUserTheme(appTheme[index]['value']);
                    Get.back();
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.black,
                );
              },
              itemCount: appTheme.length,
            ),
          ),
        );
      },
    );
  }

  getFullTheme(String theme) {
    return theme == 'light'
        ? translation.appThemeLight.tr
        : translation.appThemeDark.tr;
  }
}
