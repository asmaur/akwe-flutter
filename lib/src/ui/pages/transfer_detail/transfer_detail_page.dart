import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/ui/pages/transfer_detail/transfer_detail_page_controller.dart';
import 'package:akwe/src/ui/shared/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class TransferDetailPage extends StatelessWidget {
  const TransferDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransferDetailPageController>();
    final locale = Get.deviceLocale;
    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.addToCalendar();
            },
            icon: const Icon(FontAwesomeIcons.calendarPlus),
            tooltip: translation.appAddToCalendarTooltip.tr,
          ),
          IconButton(
            onPressed: () {
              controller.deleteCurrentTransfer();
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.appDarkGreen
                      : Colors.white,
                ),
              )
            : Column(
                children: [
                  Text(controller.transfer.value.name!),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translation.appTransferExecutionDateLabelText.tr),
                        Text(AppDateUtils().checkDate(controller.transfer.value.executionDate!)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translation.appTransferAmountLabelText.tr),
                        Text(currency.format(controller.transfer.value.amount)),
                      ],
                    ),
                  ),
                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.info_outline_rounded),
                    title: Text(
                      translation.appTransferProcessedLabelText.tr,
                    ),
                    enabled: true,
                    onTap: () {},
                    //enableFeedback: true;
                    trailing: Switch(
                      onChanged: (value) {},
                      value: controller.transfer.value.processed!,
                    ),
                  ),

                  const Gap(20),
                  const Divider(),
                  ListTile(
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                          controller.transfer.value.fromAccount!.bank!.logo!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    title: Text(controller.transfer.value.fromAccount!.bank!.name!),
                    subtitle: Text(
                      controller.transfer.value.fromAccount!.accountType!.name,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontSize: 12),
                    ),
                    // trailing: IconButton(
                    //     onPressed: () {}, icon: Icon(Icons.more_horiz_outlined),
                    // ),
                  ),
                  const Icon(
                    Icons.arrow_downward,
                    size: 26,
                  ),
                  ListTile(
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        controller.transfer.value.inAccount!.bank!.logo!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    title: Text(controller.transfer.value.inAccount!.bank!.name!),
                    subtitle: Text(
                      controller.transfer.value.inAccount!.accountType!.name,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontSize: 12),
                    ),
                    // trailing: IconButton(
                    //     onPressed: () {}, icon: Icon(Icons.more_horiz_outlined),
                    // ),
                  ),

                  const Divider(),

                  Gap(AppLayout.getHeight(10)),

                  controller.transfer.value.processed! ? const SizedBox() : SizedBox(
                    width: AppLayout.getWidth(150),
                    child: OutlinedButton(
                      onPressed: () {
                        controller.executeCurrentTransfer();
                      },
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
                ],
              ),
      ),
    );
  }
}
