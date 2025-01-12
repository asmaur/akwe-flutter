import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/ui/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:akwe/src/ui/widgets/components/goal_tile.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';

import 'goal_page_controller.dart';

class GoalPage extends StatelessWidget {
  GoalPage({super.key});
  final controller = Get.put(GoalPageController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            translation.appDrawerGoalText.tr,
            style:
                Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
          ),
          actions: [
            IconButton(
              onPressed: () => {
                // DialogHelper.showLoading(),
                controller.loadGoals(),
                // DialogHelper.hideLoading()
              },
              icon: const Icon(Icons.refresh),
              tooltip: translation.userRoutinePageRefreshButtonTooltipText.tr,
            ),
            IconButton(
              onPressed: () => {
                // Get.toNamed(Routes.NEWROUTINE),
              },
              icon: const Icon(Icons.add),
              tooltip: translation.appGoalCreateGoalTitle.tr,
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  translation.appActiveButtonLabel.tr,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  translation.appArchivedButtonLabel.tr,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        drawer: AppDrawerMobile(),
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.appDarkGreen
                        : Colors.white,
                  ),
                )
              : TabBarView(
                  children: [
                    controller.activeUserGoals.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.activeUserGoals.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GoalTile(
                                  goal: controller.activeUserGoals[index]);
                            },
                          )
                        : Container(
                            child: Center(
                              child: Text(translation.appGoalNoGoalFound.tr),
                            ),
                          ),
                    controller.archivedUserGoals.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.archivedUserGoals.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GoalTile(
                                  goal: controller.archivedUserGoals[index]);
                            },
                          )
                        : Container(
                            child: Center(
                              child: Text(translation.appGoalNoGoalFound.tr),
                            ),
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
