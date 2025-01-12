import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/pages/dashboard/dashboard_controller.dart';
import 'package:akwe/src/ui/pages/home/home.dart';
import 'package:akwe/src/ui/pages/scanner/scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';

import 'app_drawer_header.dart';
import 'drawer_navigation_item.dart';

class AppDrawerMobile extends StatelessWidget {
  const AppDrawerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    final controller = Get.put(DashBoardController());
    return NavigationDrawer(
      selectedIndex: controller.tabIndex,
      onDestinationSelected: controller.changeTabIndex,
      indicatorColor: AppColors.appLightBlue,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(
              "data name",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black
            ),
          ),
          accountEmail: Text(
              "data@gmail.com",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black
            ),
          ),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250",
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white38,
              // image: DecorationImage(
              //     image: AssetImage(
              //       "assets/images/bg1.jpg",
              //     ),
              //     fit: BoxFit.cover,
              //   opacity: 0.3,
              // ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'APP MENU',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          label: Text(
            translation.bottomBarHomeText.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          icon: const Icon(Icons.apps_outlined),
          selectedIcon: const Icon(Icons.apps_outlined),
        ),
        NavigationDrawerDestination(
          label: Text(
            translation.bottomBarTransactionText.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          icon: const Icon(Icons.transform_outlined),
          selectedIcon: const Icon(Icons.transform_outlined),
        ),

        NavigationDrawerDestination(
          label: Text(
            translation.userRoutinePageTitle.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          icon: const Icon(Icons.map_outlined),
          selectedIcon: const Icon(Icons.map_outlined),
        ),
        NavigationDrawerDestination(
          label: Text(
            translation.appDrawerGoalText.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          icon: const Icon(Icons.flag_outlined),
          selectedIcon: const Icon(Icons.flag_outlined),
        ),
        NavigationDrawerDestination(
          label: Text(
            translation.bottomBarSearchText.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          icon: const Icon(Icons.search_outlined),
          selectedIcon: const Icon(Icons.search_outlined),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        DrawerNavigationItem(
          iconData: Icons.category_outlined,
          label: translation.appDrawerCategoryText.tr,
          selected: false,
          onTap: () => {Get.toNamed(AppRoutes.USERCATEGORY)},
        ),
        DrawerNavigationItem(
          iconData: Icons.account_balance_outlined,
          label: translation.appDrawerAccountText.tr,
          selected: false,
          onTap: () => { Get.toNamed(AppRoutes.USERACCOUNT)},
        ),
        DrawerNavigationItem(
          iconData: Icons.savings_outlined,
          label: translation.appDrawerFundsText.tr,
          selected: false,
          onTap: () => {Get.toNamed(AppRoutes.USERFUNDS)},
        ),
        DrawerNavigationItem(
          iconData: Icons.money_outlined,
          label: translation.appDrawerBudgetText.tr,
          selected: false,
          onTap: () => {Get.toNamed(AppRoutes.BUDGET)},
        ),
        DrawerNavigationItem(
          iconData: Icons.sync_alt_outlined,
          label: translation.bottomBarTransferText.tr,
          selected: false,
          onTap: () => {Get.toNamed(AppRoutes.TRANSFERS)},
        ),
        DrawerNavigationItem(
          iconData: Icons.bar_chart_outlined,
          label: translation.appDrawerMetricText.tr,
          selected: false,
          onTap: () => {},
        ),
        // DrawerNavigationItem(
        //   iconData: Icons.pages,
        //   label: "Perfil",
        //   selected: false,
        //   onTap: () => {},
        // ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        // NavigationDrawerDestination(
        //   label: Text(
        //     "Support",
        //     style: Theme.of(context).textTheme.titleMedium?.copyWith(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 18,
        //         ),
        //   ),
        //   icon: const Icon(Icons.info_outline),
        //   selectedIcon: const Icon(Icons.info_outline),
        // ),
        DrawerNavigationItem(
          iconData: Icons.settings_outlined,
          label: translation.appDrawerSettingText.tr,
          selected: false,
          onTap: () => {},
        ),
        DrawerNavigationItem(
          iconData: Icons.info_outline,
          label: translation.appDrawerSupportLabel.tr,
          selected: false,
          onTap: () => {},
        ),

        SizedBox(height: 50,),

      ],
    );
  }
}
