import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poupey/src/admob/app_ad_manager.dart';
import 'package:poupey/src/constants/app_layout.dart';
import 'package:poupey/src/routes/app_pages.dart';
import 'more_options_controller.dart';
import 'package:poupey/src/translations/translation_keys.dart' as translation;

class MoreOptionPage extends StatelessWidget {
  const MoreOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoreOptionsController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              translation.appMoreOptionsPageTitle.tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 18),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.SETTINGS);
                },
                icon: const Icon(Icons.settings),
                tooltip: "Settings",
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.info_outline),
                tooltip: "info",
              )
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: translation.appMoreOptionsManageTabText.tr,
                ),
                Tab(
                  text: translation.appMoreOptionsGeneralTabText.tr,
                ),
                Tab(text: translation.appAboutText.tr)
              ],
            )),
        body: TabBarView(children: [
          Container(
            margin: EdgeInsets.only(top: AppLayout.getHeight(50)),
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.USERDATA);
                  },
                  leading: const Icon(Icons.person_outline),
                  title: Text(
                    translation.appUserDataText.tr,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.USERPREMIUM);
                  },
                  leading: const Icon(Icons.star_border),
                  title: Text(translation.appPremiumPlanText.tr),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.USERACCOUNT);
                  },
                  leading: const Icon(Icons.account_balance),
                  title: Text(translation.appDrawerAccountText.tr),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.USERCATEGORY);
                  },
                  leading: const Icon(Icons.ballot_outlined),
                  title: Text(translation.appDrawerCategoryText.tr),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                // ListTile(
                //   onTap: (){},
                //   leading: Icon(Icons.timer),
                //   title: Text('Goals'),
                //   trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: (){},),
                // ),
                // ListTile(
                //   onTap: (){},
                //   leading: Icon(Icons.cloud_upload_outlined),
                //   title: Text('Imports data'),
                //   trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: (){},),
                // ),
                // ListTile(
                //   onTap: (){},
                //   leading: Icon(Icons.cloud_download_outlined),
                //   title: Text('Export data'),
                //   trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: (){},),
                // ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: AppLayout.getHeight(50)),
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    if (!controller.premiumService.isPremium.value) {
                      AppAdManager().getNoRouteVideoInterstitialAd();
                      Get.toNamed(Routes.USERMETRICS);
                    } else {
                      Get.toNamed(Routes.USERMETRICS);
                    }
                  },
                  leading: const Icon(Icons.bar_chart),
                  title: Text(translation.appHomeMenuMetricButtonText.tr),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.USERPERFORMANCE);
                  },
                  leading: const Icon(Icons.candlestick_chart_outlined),
                  title: Text(translation.appPerformanceTitle.tr),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.calendar_month_outlined),
                  title: Text(translation.appCalendarText.tr),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: AppLayout.getHeight(50)),
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    controller.openUrl(
                        "https://play.google.com/store/apps/details?id=com.wanubit.poupey");
                  },
                  leading: const Icon(Icons.star),
                  title: Text(translation.appRatingText.tr),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  onTap: () {
                    controller
                        .openUrl("https://poupeyapp.com/terms-and-conditions");
                  },
                  leading: const Icon(Icons.info),
                  title: Text(translation.appPolicyTermsOfService.tr),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  onTap: () {
                    controller.openUrl("https://poupeyapp.com/privacy-policy");
                  },
                  leading: const Icon(Icons.security_outlined),
                  title: Text(translation.appPolicyPrivacy.tr),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  onTap: () {
                    controller.openUrl("https://poupeyapp.com/help/");
                  },
                  leading: const Icon(Icons.help),
                  title: Text(translation.appHelpPage.tr),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  onTap: () {
                    controller.openUrl("https://poupeyapp.com/sobre/");
                  },
                  leading: const Icon(Icons.info_outline),
                  title: Text(translation.appAboutText.tr),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
