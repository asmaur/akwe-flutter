import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/pages/dashboard/dashboard_controller.dart';
import 'package:akwe/src/ui/pages/goal/goal_page_view.dart';
import 'package:akwe/src/ui/pages/home/home.dart';
import 'package:akwe/src/ui/pages/planning/planning_page_view.dart';
import 'package:akwe/src/ui/pages/scanner/scanner_page_view.dart';
import 'package:akwe/src/ui/pages/search/search_page_view.dart';
import 'package:akwe/src/ui/pages/transaction/transaction_page_view.dart';
import 'package:akwe/src/ui/widgets/components/floating_menu_bottons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // final _key = GlobalKey<ExpandableFabState>();
    // final _controller = Get.put(DashBoardController());
    return GetBuilder<DashBoardController>(
      builder: (_controller) {
        return Scaffold(
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: FloatingMenuBottons(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _controller.tabIndex,
            onTap: _controller.changeTabIndex,
            mouseCursor: SystemMouseCursors.grab,
            selectedFontSize: 32,
            selectedItemColor: AppColors.appBlack,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.appBlack,
            ),
            type: BottomNavigationBarType.shifting,
            selectedIconTheme: IconThemeData(
              color: AppColors.appBlack,
              size: 40,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.blueGrey,
              size: 28,
            ),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.apps_outlined),
                label: translation.bottomBarHomeText.tr,
                backgroundColor: AppColors.appWhite,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.transform_outlined),
                label: translation.bottomBarTransactionText.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                label: translation.userRoutinePageTitle.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.flag_outlined),
                label: translation.appDrawerGoalText.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                label: translation.bottomBarSearchText.tr,
              ),
            ],
          ),
          body: SafeArea(
            child: IndexedStack(
              index: _controller.tabIndex,
              children: [
                HomeView(),
                TransactionPageView(),
                PlanningPageView(),
                GoalPageView(),
                SearchPageView()
              ],
            ),
          ),
        );
      },
    );
  }
}
