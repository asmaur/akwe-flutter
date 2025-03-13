
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poupey/src/pages/preferences/preference_controller.dart';
import 'package:poupey/src/translations/translation_keys.dart' as translation;

class PreferencePage extends StatelessWidget {
  const PreferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreferenceController());

    return Scaffold(
      appBar: AppBar(
        title: Text(translation.appUserPreferencesTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                controller.chooseLanguage(context);
              },
              title: Text(translation.appUserPreferencesLanguageTitle.tr),
              subtitle: Text(
                "${translation.appUserPreferencesLanguageSubtitle.tr}: ${controller.getFullLanguage(Get.locale!.languageCode)}",
              ),
            ),
            ListTile(
              onTap: () {
                controller.chooseTheme(context);
              },
              title: Text(translation.appUserPreferencesTheme.tr),
              subtitle: Text(
                "${translation.appUserPreferencesThemeSubtitle.tr}: ${controller.getFullTheme(Theme.of(context).brightness.name)}",
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(translation.appUserPreferencesCurrencyTitle.tr),
              subtitle: Text(
                  "${translation.appUserPreferencesCurrencySubtitle.tr}: ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).currencyName}"),
            ),
            ListTile(
              onTap: () {},
              title: Text(translation.appUserPreferencesMonthFirstDayTitle.tr),
              subtitle: Text(
                  "${translation.appUserPreferencesMonthFirstDaySubtitle.tr} 01"),
            ),
            ListTile(
              onTap: () {},
              title: Text(translation.appUserPreferencesChartPeriodTitle.tr),
              subtitle: Text(translation.appUserPreferencesChartPeriodSubtitle
                  .trParams({"intervals": "${28}"})),
            ),
            ListTile(
              onTap: () {},
              title: Text(translation.appUserPreferencesReportPeriodTitle.tr),
              subtitle: Text(translation.appUserPreferencesReportPeriodSubtitle
                  .trParams({"intervals": "${28}"})),
            ),
          ],
        ),
      ),
    );
  }
}
