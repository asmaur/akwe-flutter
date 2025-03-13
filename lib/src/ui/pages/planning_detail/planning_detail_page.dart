import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/pages/planning_detail/planning_detail_page_controller.dart';
import 'package:akwe/src/ui/shared/date_utils.dart';
import 'package:akwe/src/ui/widgets/components/routine_tile.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:akwe/src/utils/payment_type_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class PlanningDetailPage extends StatelessWidget {
  const PlanningDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PlanningDetailPageController controller =
        Get.find<PlanningDetailPageController>();
    final paymentTypes = getPaymentTypeList();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(controller.routine.value.name!, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),),
          actions: [
            IconButton(
              onPressed: () {
                // if (!controller.premiumService.isPremium.value) {
                //   AppAdManager()
                //       .getNoRouteVideoInterstitialAd();
                //   controller.addToCalendar();
                // }else {
                //   controller.addToCalendar();
                // }
                controller.addToCalendar();
              },
              icon: const Icon(FontAwesomeIcons.calendarPlus),
              tooltip: translation.appAddToCalendarTooltip.tr,
            ),
            IconButton(
              onPressed: () => {controller.deleteRoutine()},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        floatingActionButton: controller.routine.value.done!
            ? const SizedBox()
            : FloatingActionButton(
                backgroundColor: AppColors.appDarkGreen,
                onPressed: () => {
                  Get.toNamed(AppRoutes.EDITROUTINE,
                      arguments: controller.routine.value)
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
        body: controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.appDarkGreen
                      : Colors.white,
                ),
              )
            : SingleChildScrollView(
                //width: 360,
                child: Column(
                  children: [
                    Center(
                      child: RoutineTile(
                        routine: controller.routine.value
                      ),
                    ),

                    ListTile(
                      title: Text(
                          "Exp: ${AppDateUtils().checkDate(controller.routine.value.expirationDate!)}"),
                      subtitle: Container(
                          child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          SizedBox(
                            width: AppLayout.getHeight(5),
                          ),
                          AppDateUtils().getDaysDifference(controller
                                      .routine.value.expirationDate!) >=
                                  0
                              ? Text(translation.appRoutineIntervalInText.trParams({
                                  "day": AppDateUtils()
                                      .getDaysDifference(controller
                                          .routine.value.expirationDate!)
                                      .toString()
                                }).trPlural(
                                  translation.appRoutineIntervalInTextPlural
                                      .trParams({
                                    "day": AppDateUtils()
                                        .getDaysDifference(controller
                                            .routine.value.expirationDate!)
                                        .toString()
                                  }),
                                  AppDateUtils().getDaysDifference(controller
                                      .routine.value.expirationDate!)))
                              : Text(translation.appRoutineIntervalOutText
                                  .trParams({
                                  "day": AppDateUtils()
                                      .getDaysDifference(controller
                                          .routine.value.expirationDate!)
                                      .toString()
                                }).trPlural(
                                      translation
                                          .appRoutineIntervalOutTextPlural
                                          .trParams({
                                        "day": (-AppDateUtils()
                                                .getDaysDifference(controller
                                                    .routine
                                                    .value
                                                    .expirationDate!))
                                            .toString()
                                      }),
                                      -AppDateUtils().getDaysDifference(controller
                                          .routine.value.expirationDate!))),
                        ],
                      )),
                      trailing: IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ),

                    Gap(AppLayout.getHeight(30)),

                    //Gap(AppLayout.getHeight(20)),

                    controller.routine.value.done!
                        ? ListTile(
                            title:
                                Text(translation.appRoutineExecutedAtLabel.tr),
                            trailing: Text(AppDateUtils().checkDate(
                                controller.routine.value.expirationDate!)),
                          )
                        : const SizedBox(),

                    // AppAdManager().getAdaptiveBannerAd(),

                    SizedBox(
                      width: AppLayout.getWidth(150),
                      child: OutlinedButton(
                        onPressed: controller.routine.value.done!
                            ? null
                            : () => {controller.executeCurrentRoutine()},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent.shade700,
                          side: const BorderSide(color: Colors.transparent),
                        ),
                        child: Text(
                          translation.appRoutineProcessButtonText.tr,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppColors.appWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),

                    const Divider(),

                    controller.routine.value.description!.isNotEmpty
                        ? SizedBox(
                            width: AppLayout.getScreenWidth() * 0.9,
                            child: TextFormField(
                              controller: controller.description,
                              decoration: InputDecoration(
                                labelText:
                                    translation.appTextFieldDescriptionLabel.tr,
                                labelStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white),
                              ),
                              enabled: false,
                              maxLines: null,
                            ),
                          )
                        : const SizedBox(),

                  ],
                ),
              ),
      ),
    );
  }

  getPaymentType(List<PaymentType> paymentTypes, int key) {
    for (PaymentType item in paymentTypes) {
      if (item.key == key) {
        return item.value;
      }
    }
  }
}
