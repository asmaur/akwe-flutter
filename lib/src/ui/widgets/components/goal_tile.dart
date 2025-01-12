import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/constants/popup_menu.dart';
import 'package:akwe/src/data/services/goal_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/goals/app_goal.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:dio/dio.dart' as dio;

class GoalTile extends StatelessWidget {
  GoalTile({super.key, required this.goal});
  final AppGoal goal;

  @override
  Widget build(BuildContext context) {
    AppPopupMenuItem? selectedItem;
    // final premiumService = Get.find<AppPremiumService>();

    return Card(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.appDarkGreen
          : AppColors.appMidGray,
      margin: EdgeInsets.all(AppLayout.getHeight(16)),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                color: goal.color?.color,
                //controller.categoryItems[index].color?.color,
                borderRadius: BorderRadius.circular(50),
              ),
              width: 35,
              height: 35,
              child: Icon(
                goal.icon?.icon,
                //controller.categoryItems[index].icon?.icon,
                color: AppColors.appWhite,
                size: 20,
              ),
            ),
            title: Text(
              goal.name!,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontSize: 18),
            ),
            trailing: PopupMenuButton(
              initialValue: selectedItem,
              icon: const Icon(Icons.more_vert_outlined),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: AppPopupMenuItem.view,
                    child: Text(translation.appPopupMenuDetailText.tr),
                  ),
                  PopupMenuItem(
                    value: AppPopupMenuItem.edit,
                    child: Text(translation.appPopupMenuEditText.tr),
                  ),
                  PopupMenuItem(
                    value: AppPopupMenuItem.archived,
                    child:
                    Text(translation.appPopupMenuArchiveText.tr),
                  ),
                  PopupMenuItem(
                    value: AppPopupMenuItem.delete,
                    child: Text(translation.appPopupMenuDeleteText.tr),
                  )
                ];
              },
              onSelected: (AppPopupMenuItem item) {
                actionPopUpItemSelected(item, goal);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppLayout.getHeight(10)),
            child: LinearPercentIndicator(
              width: AppLayout.getScreenWidth() * 0.8,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2000,
              percent: double.parse(
                  (goal.balance! * 1 / goal.targetAmount!).toStringAsFixed(1)),
              center: Text(
                "${(goal.balance! * 100 / goal.targetAmount!).toStringAsFixed(1)}%",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              //linearStrokeCap: LinearStrokeCap.roundAll,
              barRadius: Radius.circular(AppLayout.getHeight(20)),
              progressColor: goal.color?.color,
            ),
          ),
          Container(
            padding: EdgeInsets.all(AppLayout.getHeight(5)),
            child: Text(
              "${translation.appGoalRemainingDayLabel.tr} ${goal.deadlineDate!.difference(DateTime.now()).inDays < 0 ? '0' : goal.deadlineDate!.difference(DateTime.now()).inDays}",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  archiveGoal(String id) async {
    final GoalService goalService = GoalService();
    DialogHelper.showLoading();
    try {
      dio.Response response = await goalService.archive(id);

      if (response.statusCode == StatusCode.NO_CONTENT) {
        //await _storageService.deleteAccount(id);
        DialogHelper.hideLoading();
        Get.offAllNamed(AppRoutes.HOME);
      }
    } on dio.DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  deleteGoal(String id) async {
    final GoalService goalService = GoalService();
    DialogHelper.showLoading();
    try {
      dio.Response response = await goalService.delete(id);

      if (response.statusCode == StatusCode.NO_CONTENT) {
        //await _storageService.deleteAccount(id);
        DialogHelper.hideLoading();
        Get.offAllNamed(AppRoutes.HOME);
      }
    } on dio.DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }

  void actionPopUpItemSelected(AppPopupMenuItem item, AppGoal goal) {
    // final premiumService = Get.find<AppPremiumService>();

    switch (item) {
      case AppPopupMenuItem.view:
        // if(!premiumService.isPremium.value) {
        //   AppAdManager().getNoRouteVideoInterstitialAd();
        //   Get.toNamed(Routes.USERGOALDETAIL, arguments: goal);
        // }else {
        //   Get.toNamed(Routes.USERGOALDETAIL, arguments: goal);
        // }
        Get.toNamed(AppRoutes.USERGOALDETAIL, arguments: goal);
        return;
      case AppPopupMenuItem.edit:
        // if(!premiumService.isPremium.value) {
        //   AppAdManager().getNoRouteVideoInterstitialAd();
        //   Get.toNamed(Routes.EDITUSERGOAL, arguments: goal);
        // }else {
        //   //AppAdManager().getNoRouteVideoInterstitialAd();
        //   Get.toNamed(Routes.EDITUSERGOAL, arguments: goal);
        // }
        Get.toNamed(AppRoutes.EDITUSERGOAL, arguments: goal);
        return;
      case AppPopupMenuItem.archived:
        DialogHelper.showErrorDialog(
          title: translation.appMessageConfirm.tr,
          description: translation.appMessageConfirmText
              .trParams({"name": "${goal.name}"}),
          onConfirm: () => archiveGoal(goal.id!),
        );
        return;
      case AppPopupMenuItem.delete:
        DialogHelper.showErrorDialog(
          title: translation.appMessageConfirm.tr,
          description: translation.appMessageConfirmText
              .trParams({"name": "${goal.name}"}),
          onConfirm: () => deleteGoal(goal.id!),
        );
        return;
      case AppPopupMenuItem.all:
        // TODO: Handle this case.
      case AppPopupMenuItem.pPrevious:
        // TODO: Handle this case.
      case AppPopupMenuItem.restore:
        // TODO: Handle this case.
    }
  }

}
