import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/ui/pages/planning/planning_page_view_controller.dart';
import 'package:akwe/src/ui/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:akwe/src/ui/widgets/components/routine_tile.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PlanningPageView extends StatelessWidget {
  PlanningPageView({super.key});
  final controller = Get.put(PlanningPageViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translation.userRoutinePageTitle.tr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
          ),
          //automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () =>
              {
                // DialogHelper.showLoading(),
                // controller.refreshCurrentMonthRoutine(),
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
              tooltip: translation.userRoutinePageNewRoutineButtonTooltipText.tr,
            ),
            IconButton(
              onPressed: () {
                // Get.toNamed(Routes.ROUTINEFILTER);
              },
              icon: const Icon(Icons.filter_alt),
              tooltip: translation.userRoutinePageMoreRoutineButtonTooltipText.tr,
            ),
          ],
        ),
        drawer: AppDrawerMobile(),
      body: RefreshIndicator(
        onRefresh: () => controller.getCurrentMonthRoutine(),
        child: Obx(
              () =>
          controller.routines.isNotEmpty
              ? DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  child: TabBar(
                    //isScrollable: true;
                    tabs: [
                      Tab(
                        //icon: Icon(Icons.calendar_today);
                        text: translation.userRoutinePageToday.tr,
                      ),
                      Tab(
                        //icon: Icon(Icons.calendar_view_week);
                        text: translation.userRoutinePageWeek.tr,
                      ),
                      Tab(
                        //icon: Icon(Icons.calendar_month);
                        text: translation.userRoutinePageMonth.tr,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Tab(
                        child: controller.todayRoutines.isNotEmpty
                            ? ListView.separated(
                          itemCount:
                          controller.todayRoutines.length,
                          //shrinkWrap: true;
                          //scrollDirection: Axis.vertical;
                          physics:
                          const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return Center(
                                child: RoutineTile(
                                  routine:
                                  controller.todayRoutines[index],
                                ));
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            if (index % 2 == 0) {
                              return SizedBox();//AppAdManager().getBannerAd();
                            } else if (controller
                                .todayRoutines.length -
                                1 ==
                                index) {
                              return SizedBox();//AppAdManager().getBannerAd();
                            }
                            return const SizedBox();
                          },
                        )
                            : Container(
                          child: Center(
                            child: Text(
                              translation
                                  .userRoutinePageTodayNoRoutine.tr,
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: controller.weekRoutines.isNotEmpty
                            ? ListView.separated(
                          itemCount: controller.weekRoutines.length,
                          //shrinkWrap: true;
                          //scrollDirection: Axis.vertical;
                          physics:
                          const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return Center(
                              child: RoutineTile(
                                routine:
                                controller.weekRoutines[index],
                              ),
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            if (index % 2 == 0) {
                              return SizedBox();//AppAdManager().getBannerAd();
                            } else if (controller
                                .weekRoutines.length -
                                1 ==
                                index) {
                              return SizedBox();//AppAdManager().getBannerAd();
                            }
                            return const SizedBox();
                          },
                        )
                            : Container(
                          child: Center(
                            child: Text(translation
                                .userRoutinePageWeekNoRoutine.tr),
                          ),
                        ),
                      ),
                      Tab(
                        child: controller.routines.isNotEmpty
                            ? ListView.separated(
                          itemCount: controller.routines.length,
                          //shrinkWrap: true;
                          //scrollDirection: Axis.vertical;
                          physics:
                          const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return Center(
                                child: RoutineTile(
                                  routine: controller.routines[index],
                                ));
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            if (index % 2 == 0) {
                              return SizedBox();//AppAdManager().getBannerAd();
                            } else if (controller.routines.length -
                                1 ==
                                index) {
                              return SizedBox();//AppAdManager().getBannerAd();
                            }
                            return const SizedBox();
                          },
                        )
                            : Container(
                          child: Center(
                            child: Text(translation
                                .userRoutinePageMonthNoRoutine.tr),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
              : ListView(
            //scrollDirection: Axis.vertical;
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                //width: double.infinity;
                height: AppLayout.getScreenHeight() * 0.4,
                //color: Colors.red;
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/plans-tasks.png"),
                ),
              ),
              const Gap(15),
              Center(
                child:
                Text(translation.userRoutinePageEmptyRoutineText.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
