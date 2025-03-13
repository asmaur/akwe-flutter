import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poupey/src/routes/app_pages.dart';
import 'package:poupey/src/translations/translation_keys.dart' as translation;

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation.appSettingPageTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: (){
              Get.toNamed(Routes.PREFERENCES);
            },
            leading: const CircleAvatar(child: Icon(Icons.person_2_outlined)),
            title: Text(translation.appPreferenceTitle.tr),
            subtitle: Text(translation.appPreferenceSubtitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),),
            trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: (){},),
          ),
          ListTile(
            onTap: (){
              Get.toNamed(Routes.ALERTNOTIFICATION);
            },
            leading: const CircleAvatar(child: Icon(Icons.notifications)),
            title: Text(translation.appAlertAndNotificationTitle.tr),
            subtitle: Text(translation.appAlertAndNotificationSubtitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),),
            trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: (){},),
          ),
          ListTile(
            onTap: (){
              Get.toNamed(Routes.SECURITYSETTING);
            },
            leading: const CircleAvatar(child: Icon(Icons.safety_check)),
            title: Text(translation.appSecurityTitle.tr),
            subtitle: Text(translation.appSecuritySubtitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),),
            trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: (){},),
          ),
          ListTile(
            onTap: (){
              Get.toNamed(Routes.ADVANCEDSETTING);
            },
            leading: const CircleAvatar(child: Icon(Icons.settings)),
            title: Text(translation.appAdvancedSettingTitle.tr),
            subtitle: Text(translation.appAdvancedSettingSubtitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),),
            trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: (){},),
          ),
        ],
      ),
    );
  }
}
